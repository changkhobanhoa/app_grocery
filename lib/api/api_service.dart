import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_flutter/main.dart';
import 'package:grocery_flutter/models/cart.dart';
import 'package:grocery_flutter/models/favorite_user.dart';
import 'package:grocery_flutter/models/user.model.dart';

import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/category.dart';
import '../models/login_response_model.dart';
import '../models/order_payment.dart';
import '../models/product.dart';
import '../models/product_filter.dart';
import '../models/slider.model.dart';
import '../utils/shared_service.dart';

final apiService = Provider((ref) => ApiService());

class ApiService {
  static var client = http.Client();
  static Map<String, String> requestHeaders = {
    'Content-Type': 'application/json'
  };
  Future<List<Category>?> getCategories(page, pageSize) async {
    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString()
    };

    var url = Uri.http(Config.apiURL, Config.categoryApi, queryString);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return categoriesFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<List<Product>?> getProducts(
      ProductFilterModel productFilterModel) async {
    Map<String, String> queryString = {
      'page': productFilterModel.paginationModel.page.toString(),
      'pageSize': productFilterModel.paginationModel.pageSize.toString()
    };

    if (productFilterModel.categoryId != null) {
      queryString["categoryId"] = productFilterModel.categoryId!;
    }

    if (productFilterModel.sortBy != null) {
      queryString["sort"] = productFilterModel.sortBy!;
    }
    if (productFilterModel.productIds != null) {
      queryString["productIds"] = productFilterModel.productIds!.join(",");
    }

    var url = Uri.http(Config.apiURL, Config.productApi, queryString);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return productFromJson(data["data"]);
    } else {
      return null;
    }
  }

  static Future<bool> registerUser(
      String fullName, String email, String password) async {
    var url = Uri.http(Config.apiURL, Config.registerApi);

    var respons = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"fullName": fullName, "email": email, "password": password},
      ),
    );
    if (respons.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    var url = Uri.http(Config.apiURL, Config.loginApi);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"email": email, "password": password},
      ),
    );
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
          loginResponseModelJson(response.body));
      return true;
    } else {
      return false;
    }
  }
   

  Future<List<SliderModel>?> getSliders(page, pageSize) async {
    var url = Uri.http(
      Config.apiURL,
      Config.sliderApi,
    );

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return slidersFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<Product?> getProductDetails(String productId) async {
    try {
      var url = Uri.http(Config.apiURL, "${Config.productApi}/$productId");
      var response = await client.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return Product.fromJson(data["data"]);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
   

  Future<Cart?> getCart() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.cartApi);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data == null) {
        return null;
      }
      return Cart.fromJson(data["data"]);
    } else if (response.statusCode == 401) {
      const snackBar = SnackBar(
        content: Text('Vui lòng đăng nhập để xem giỏ hàng'),
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      return null;
    }
    return null;
  }

  Future<bool?> addCartItem(productId, qty) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.parse("${Config.imageURL}/${Config.cartApi}");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "products": [
            {
              "product": productId,
              "qty": qty,
            }
          ]
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      return null;
    }
    return null;
  }

  Future<bool?> removeCartItem(productId, qty) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.parse("${Config.imageURL}/${Config.cartApi}");
    var response = await client.delete(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "productId": productId,
          "qty": qty,
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      return null;
    }
    return null;
  }

  Future<Map<String, dynamic>> processPayment(cardHolderName, cardNumber,
      cardExpMonth, cardExpYear, cardCVC, amount) async {
    var lodingDetail = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${lodingDetail?.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.orderApi);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "card_Name": cardHolderName,
        "card_Number": cardNumber,
        "card_ExpMonth": cardExpMonth,
        "card_ExpYear": cardExpYear,
        "amount": amount,
        "card_CVC": cardCVC,
      }),
    );
    Map<String, dynamic> resModel = {};
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      resModel["message"] = "success";
      resModel["data"] = OrderPayment.fromJson(data["data"]);
    } else if (response.statusCode == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
    } else {
      var data = jsonDecode(response.body);
      resModel["message"] = data["error"];
    }
    return resModel;
  }

  Future<bool?> updateOrder(orderId, transactionId) async {
    var lodingDetail = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${lodingDetail?.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.orderApi);
    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "status": "success",
        "transactionId": transactionId,
        "orderId": orderId,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
    } else {
      return false;
    }
    return null;
  }

  Future<FavoriteUser?> getFavorite() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.favoriteApi);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return FavoriteUser.fromJson(data["data"]);
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      return null;
    }
    return null;
  }

  Future<String?> addFavorite(productId) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.favoriteApi);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "productId": productId,
        },
      ),
    );
    if (response.statusCode == 200) {
      return "Success";
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      var data = jsonDecode(response.body);
      return data['message'];
    }
    return null;
  }

  Future<bool?> removeFavorite(productId) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.favoriteApiDelete);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "productId": productId,
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      return null;
    }
    return null;
  }
}

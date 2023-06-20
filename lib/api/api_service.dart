import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_flutter/main.dart';
import 'package:grocery_flutter/models/cart.dart';

import 'package:http/http.dart' as http;
import 'package:snippet_coder_utils/FormHelper.dart';

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
  Future<List<Category>?> getCategories(Page, pageSize) async {
    Map<String, String> queryString = {
      'page': Page.toString(),
      'pageSize': pageSize.toString()
    };

    var url = Uri.http(Config.api_URL, Config.category_api, queryString);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
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

    var url = Uri.http(Config.api_URL, Config.product_api, queryString);
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
    var url = Uri.http(Config.api_URL, Config.register_api);

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
    var url = Uri.http(Config.api_URL, Config.login_api);
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
      Config.api_URL,
      Config.slider_api,
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
      var url = Uri.http(Config.api_URL, "${Config.product_api}/$productId");
      var response = await client.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return Product.fromJson(data["data"]);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

   Future<Cart?> getCart() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.http(Config.api_URL, Config.cart_api);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(response.body);
      return Cart.fromJson(data["data"]);
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
  Future<bool?> addCartItem(productId, qty) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.parse("${Config.imageURL}/${Config.cart_api}");
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
    var url = Uri.parse("${Config.imageURL}/${Config.cart_api}");
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
    var url = Uri.http(Config.api_URL, Config.order_api);
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
    var url = Uri.http(Config.api_URL, Config.order_api);
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
}

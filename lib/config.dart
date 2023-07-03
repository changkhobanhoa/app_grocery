import 'package:intl/intl.dart';

class Config {
  static const String appName = "Grocery App";
  static const String apiURL = "192.168.1.21:4000";
  static const String categoryApi = "api/category";
  static const String productApi = "api/product";
  static const String registerApi = "api/register";
  static const String loginApi = "api/login";
  static const String sliderApi = "api/slider";
  static const String cartApi = "api/cart";
  static const String orderApi = "api/order";
  static const String imageURL = "http://192.168.1.21:4000";
  static const int pageSize = 10;
  static const String currency = "đ";
  static const String favoriteApi="api/favorite";
  static const String favoriteApiDelete="api/favorite/remove";
  
}
String formatVnd(double amountInVnd) {
  return NumberFormat.currency(locale: 'vi_VN', symbol: '₫', decimalDigits: 0)
      .format(amountInVnd);
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../config.dart';
import 'category.dart';
part 'product.freezed.dart';
part 'product.g.dart';

List<Product> productFromJson(dynamic str) =>
    List<Product>.from((str).map((e) => Product.fromJson(e)));

 

@freezed
abstract class Product with _$Product {
  factory Product({
    required String productName,
    required Category? category,
    required String? productShortDescription,
    required String? productDescription,
    required double productPrice,
    required double productSalePrice,
    required String productImage,
    required String? productSKU,
    required String? productType,
    required String? stackStatus,
    required String productId,
    required bool? isFavorite,
    List<String>? relatedProducts,
  }) = _Product;
  factory Product.defaultFavorite({
    required String productName,
    required Category? category,
    required String? productShortDescription,
    required String? productDescription,
    required double productPrice,
    required double productSalePrice,
    required String productImage,
    required String? productSKU,
    required String? productType,
    required String? stackStatus,
    required String productId,
    bool isFavorite = false,
    List<String>? relatedProducts,
  }) =>
      Product(
        productName: productName,
        category: category,
        productShortDescription: productShortDescription,
        productDescription: productDescription,
        productPrice: productPrice,
        productSalePrice: productSalePrice,
        productImage: productImage,
        productSKU: productSKU,
        productType: productType,
        stackStatus: stackStatus,
        productId: productId,
        isFavorite: isFavorite,
        relatedProducts: relatedProducts,
      );

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

}

extension ProductExt on Product {
  String get fullImagePath => Config.imageURL + productImage;

  int get calculateDiscount {
    double disPercent = 0;

    if (!productPrice.isNaN) {
      double regularPrice = productPrice;
      double salePrice =
          productSalePrice > 0 ? productSalePrice : regularPrice;
      double discount = regularPrice - salePrice;
      disPercent = (discount / regularPrice) * 100;
    }
    return disPercent.round();
  }
}

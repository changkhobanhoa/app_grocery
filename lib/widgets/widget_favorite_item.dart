import 'package:flutter/material.dart';
import 'package:grocery_flutter/models/favorite.dart';
import 'package:grocery_flutter/models/product.dart';

import '../config.dart';

class FavoriteItemWidget extends StatelessWidget {
  final Favorite model;
  final Function? onItemRemove;

  const FavoriteItemWidget({Key? key, required this.model, this.onItemRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                model.product.productImage != ""
                    ? model.product.fullImagePath
                    : "",
                width: 80.0,
                height: 80.0,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context,"/product-details",arguments:{'productId':model.product.productId});
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model.product.productName,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "${Config.currency}${model.product.productPrice.toString()}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              color: model.product.calculateDiscount > 0
                                  ? Colors.red
                                  : Colors.black,
                              decoration: model.product.productSalePrice > 0
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          Text(
                            (model.product.calculateDiscount > 0)
                                ? " ${Config.currency}${model.product.productSalePrice.toString()}"
                                : "",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
              onItemRemove!(model.product.productId);
              },
            ),
          ],
        ),
      ),
    );
  }
}

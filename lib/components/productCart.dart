import 'package:flutter/material.dart';

import '../config.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product model;
  final Function? addFavorite;
  final bool isFavorite;
  const ProductCard({
    super.key,
    required this.model,
    this.addFavorite, required this.isFavorite,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      decoration: const BoxDecoration(color: Colors.white),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: model.calculateDiscount > 0,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Text(
                      "${model.calculateDiscount}% OFF",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    model.fullImagePath,
                    fit: BoxFit.contain,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed("/product-details",
                      arguments: {'productId': model.productId});
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 10),
                child: Text(
                  model.productName,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Text(
                              formatVnd(model.productPrice),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                color: model.calculateDiscount > 0
                                    ? Colors.black
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                                decoration: model.calculateDiscount > 0
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            Text(
                              (model.calculateDiscount > 0)
                                  ? " ${formatVnd(model.productSalePrice)}"
                                  : "",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.favorite,
                          color:  isFavorite ? Colors.red : Colors.grey,
                        ),
                        onTap: () {
                          addFavorite!(model.productId);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

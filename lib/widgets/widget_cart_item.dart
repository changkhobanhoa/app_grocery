import 'package:flutter/material.dart';
import '/models/product.dart';

import '../components/widget_custom_stepper.dart';
import '../config.dart';
import '../models/cart_product.dart';

class CartItemWidget extends StatelessWidget {
  final CartProduct model;
  final Function? onQtyUpdate;
  final Function? onItemRemove;

  const CartItemWidget({
    super.key,
    required this.model,
    this.onQtyUpdate,
    this.onItemRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      borderOnForeground: true,
      child: Container(
        height: 120,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 1),
            bottom: BorderSide(color: Colors.grey, width: 1),
            left: BorderSide(color: Colors.grey, width: 5),
            right: BorderSide(color: Colors.grey, width: 1),
          ),
          color: Colors.white,
        ),
        child: cartItemUI(context),
      ),
    );
  }

  Widget cartItemUI(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(children: [
          Column(
            children: [
              Visibility(
                visible: model.product.calculateDiscount > 0,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Text(
                      "${model.product.calculateDiscount}% OFF",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: GestureDetector(
                child: Container(
                  width: 100,
                  child: Image.network(
                    model.product.productImage != ""
                        ? model.product.fullImagePath
                        : "",
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ))
            ],
          )
        ]),
        SizedBox(
          width: 230,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.product.productName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    "${model.product.productPrice.toString()} ${Config.currency}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
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
                        ? " ${model.product.productSalePrice.toString()} ${Config.currency}"
                        : "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomStepper(
                    lowerLimit: 1,
                    upperLimit: 20,
                    stepValue: 1,
                    iconSize: 15.0,
                    value: model.qty.toInt(),
                    onChanged: (value) {
                      onQtyUpdate!(model, value["qty"], value["type"]);
                    },
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        onItemRemove!(model);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_flutter/models/cart.dart';

import '../config.dart';
import '../models/cart_product.dart';
import '../providers.dart';
import '../widgets/widget_cart_item.dart';
 

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cart"),
      ),
      bottomNavigationBar: checkoutBottomNavbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(  
            flex: 1,
            child: _cartList(ref),
          )
        ],
      ),
    );
  }

  Widget _buildCartItem(List<CartProduct> cartProduct, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: cartProduct.length,
      itemBuilder: (context, index) {
        return CartItemWidget(
          model: cartProduct[index],
          onQtyUpdate: (CartProduct model, qty, type) {
            final cartViewModel = ref.read(cartItemsProvider.notifier);
            cartViewModel.updateQty(model.product.productId, qty, type);
          },
          onItemRemove: (CartProduct model) {
            final cartViewModel = ref.read(cartItemsProvider.notifier);
            cartViewModel.removeCartItem(model.product.productId, model.qty);
          },
        );
      },
    );
  }

  Widget _cartList(WidgetRef ref) {
    final cartState = ref.watch(cartItemsProvider);
    if (cartState.cartModel == null) {
      return const LinearProgressIndicator();
    }

    if (cartState.cartModel!.products.isEmpty) {
      return const Center(
        child: Text(
          'Cart Empty',
        ),
      );
    }
    return _buildCartItem(cartState.cartModel!.products, ref);
  }
}

class checkoutBottomNavbar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(cartItemsProvider);

    if (cartProvider.cartModel != null) {
      return cartProvider.cartModel!.products.isNotEmpty
          ? Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0),
            child: Container(
                 
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tổng: ${cartProvider.cartModel!.grandTotal.toString()} ${Config.currency}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      child: const Text(
                        "Thanh toán",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed("/payments");
                      },
                    )
                  ],
                ),
              ),
            ),
          )
          : const SizedBox();
    }
    return const SizedBox();
  }
}
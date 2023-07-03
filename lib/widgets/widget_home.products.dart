 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_flutter/models/favorite.dart';

import '../components/productCart.dart';
import '../models/pagination.dart';
import '../models/product.dart';
import '../models/product_filter.dart';
import '../providers.dart';

class HomeProductsWidget extends ConsumerWidget {
  const HomeProductsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: const Color(0xffF4F7FA),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 15),
                child: Text(
                  "Top 10 Products",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: _productList(ref),
          ),
        ],
      ),
    );
  }

  Widget _productList(WidgetRef ref) {
    final products = ref.watch(
      homeProductProvider(
        ProductFilterModel(
          paginationModel: PaginationModel(page: 1, pageSize: 10),
        ),
      ),
    );
    final favorites = ref.watch(favoriteItemProvider);

    return products.when(
        data: (list) {
          if (favorites==null) {
            return _builProductList1(list!, ref);
          }
          return _builProductList(
              list!, favorites.favoriteModel!.favorites, ref);
        },
        error: (_, __) {
          return const Center(child: Text("ERROR"));
        },
        loading: () => const Center(child: CircularProgressIndicator()));
  }

  Widget _builProductList1(List<Product> product, WidgetRef ref) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: product.length,
        itemBuilder: (context, index) {
          var data = product[index];

          return GestureDetector(
            onTap: () {},
            child: ProductCard(
                model: data,
                addFavorite: (productId) {
                  final favoriteModel = ref.read(favoriteItemProvider.notifier);
                  favoriteModel.addFavoriteItem(productId);
                },
                checkFavorite: const Icon(
                  Icons.favorite,
                  color: Colors.grey,
                  size: 20,
                )),
          );
        },
      ),
    );
  }

  Widget _builProductList(
      List<Product> product, List<Favorite>? favorite, WidgetRef ref) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: product.length,
        itemBuilder: (context, index) {
          var data = product[index];
          var check = 0;
          if (favorite!.isEmpty) {
          } else {
            favorite.map((e) {
              if (e.product.productId == data.productId) {
                check = 1;
              }
            });
          }
          return GestureDetector(
            onTap: () {},
            child: ProductCard(
              model: data,
              addFavorite: (productId) {
                final favoriteModel = ref.read(favoriteItemProvider.notifier);
                favoriteModel.addFavoriteItem(productId);
              },
              checkFavorite: check == 0
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.grey,
                      size: 20,
                    )
                  : const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20,
                    ),
            ),
          );
        },
      ),
    );
  }
}

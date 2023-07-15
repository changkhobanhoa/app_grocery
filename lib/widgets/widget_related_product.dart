import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/productCart.dart';
import '../models/favorite.dart';
import '../models/pagination.dart';
import '../models/product.dart';
import '../models/product_filter.dart';
import '../providers.dart';

class RelatedProductWidget extends ConsumerWidget {
  final List<String> relatedProduct;
  const RelatedProductWidget(this.relatedProduct, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Text(
          " ",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Visibility(
          // relatedProduct?.where((e) => e != null).toList().isEmpty ??
          visible: relatedProduct.isNotEmpty,
          child: _productList(ref),
        )
      ],
    );
  }

  Widget _productList(WidgetRef ref) {
    final products = ref.watch(
      relatedProductsProvider(
        ProductFilterModel(
          paginationModel: PaginationModel(
            page: 1,
            pageSize: 10,
          ),
          productIds: relatedProduct,
        ),
      ),
    );
    return products.when(
      data: (list) {
        return _buildProductList(list!, ref);
      },
      error: (_, __) => const Center(
        child: Text("Error"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildProductList(List<Product> product, WidgetRef ref) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: product.length,
        itemBuilder: (context, index) {
          var data = product[index];

          return GestureDetector(
            onTap: () {},
            child: ProductCard(
              model: data,
              addFavorite: (productId) async {
                final favoriteModel = ref.read(favoriteItemProvider.notifier);
                await favoriteModel.addFavoriteItem(productId);
                final favoriteState = ref.watch(favoriteItemProvider);
                favoriteState.err != null ? "" : "";
              },
            ),
          );
        },
      ),
    );
  }
}

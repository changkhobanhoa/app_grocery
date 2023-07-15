import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/components/productCart.dart';

import '../models/pagination.dart';
import '../models/product_filter.dart';
import '../models/product_sort.dart';
import '../providers.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductPage> {
  String? categoryId;
  String? categoryName;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text("Sản phẩm"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Container(
        color: Colors.grey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductFilter(
              categoryName: categoryName,
              categoryId: categoryId,
            ),
            Flexible(
              flex: 1,
              child: _ProductList(),
            )
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    categoryName = arguments['categoryName'];
    categoryId = arguments['categoryId'];

    super.didChangeDependencies();
  }
}

class _ProductFilter extends ConsumerWidget {
  final _sortByOption = [
    ProductSortModel(value: "createdAt", label: "Latest"),
    ProductSortModel(value: "-product_price", label: "Price: High to Low"),
    ProductSortModel(value: "product_price", label: "Price: Low to High"),
  ];

  _ProductFilter({
    this.categoryName,
    this.categoryId,
  });

  final String? categoryName;
  final String? categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterProvider = ref.watch(productFilterProvider);
    return Container(
      height: 51,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              categoryName!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: PopupMenuButton(
              onSelected: (sortBy) {
                ProductFilterModel filterModel = ProductFilterModel(
                    paginationModel: PaginationModel(page: 0, pageSize: 10),
                    categoryId: filterProvider.categoryId,
                    sortBy: sortBy.toString());
                ref
                    .read(productFilterProvider.notifier)
                    .setProductFilter(filterModel);
                ref.read(productNotifierProvider.notifier).getProducts();
              },
              initialValue: filterProvider.sortBy,
              itemBuilder: (BuildContext context) {
                return _sortByOption.map(
                  (item) {
                    return PopupMenuItem(
                      value: item.value,
                      child: InkWell(
                        child: Text(item.label!),
                      ),
                    );
                  },
                ).toList();
              },
              icon: const Icon(Icons.filter_list_alt),
            ),
          )
        ],
      ),
    );
  }
}

class _ProductList extends ConsumerWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productNotifierProvider);

    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          final producstViewModel = ref.read(productNotifierProvider.notifier);
          final productState = ref.watch(productNotifierProvider);

          if (productState.hasNext) {
            producstViewModel.getProducts();
          }
        }
      },
    );

    if (productState.products.isEmpty) {
      if (!productState.hasNext && !productState.isLoading) {
        return const Center(
          child: Text("Not produts"),
        );
      }
      return const LinearProgressIndicator();
    }

    return RefreshIndicator(
        onRefresh: () async {
          ref.read(productNotifierProvider.notifier).refreshProduct();
        },
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: GridView.count(
                crossAxisCount: 2,
                controller: _scrollController,
                children: List.generate(
                  productState.products.length,
                  (index) {
                    return ProductCard(
                      model: productState.products[index],
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible:
                  productState.isLoading && productState.products.isNotEmpty,
              child: const SizedBox(
                height: 35,
                width: 35,
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ));
  }
}

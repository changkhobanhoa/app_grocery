import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/application/notifier/favorite_notifier.dart';
import '/application/notifier/order_payment_notifier.dart';
import '/application/state/favorite_state.dart';
import '/application/state/order_payment_state.dart';
import '/models/product.dart';
import '/models/product_filter.dart';
import '/models/slider.model.dart';

import 'api/api_service.dart';
import 'application/notifier/cart_notifier.dart';
import 'application/notifier/product_filter_notifier.dart';
import 'application/notifier/product_notifier.dart';
import 'application/state/cart_state.dart';
import 'application/state/product_state.dart';
import 'models/category.dart';
import 'models/pagination.dart';

final categoriesProvider =
    FutureProvider.family<List<Category>?, PaginationModel>(
  (ref, paginationModel) {
    final apiRepository = ref.watch(apiService);
    return apiRepository.getCategories(
      paginationModel.page,
      paginationModel.pageSize,
    );
  },
);
final homeProductProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>(
        (ref, productFilterModel) {
  final apiRepository = ref.watch(apiService);

  return apiRepository.getProducts(productFilterModel);
});
final productFilterProvider =
    StateNotifierProvider<ProductFilterNotifier, ProductFilterModel>(
        (ref) => ProductFilterNotifier());

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductState>(
  (ref) => ProductNotifier(
    ref.watch(apiService),
    ref.watch(productFilterProvider),
  ),
);
 

final sliderProvider =
    FutureProvider.family<List<SliderModel>?, PaginationModel>(
        (ref, paginationModel) {
  final sliderRepo = ref.watch(apiService);
  return sliderRepo.getSliders(paginationModel.page, paginationModel.pageSize);
});

final relatedProductsProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>(
  (ref, productFilterModel) {
    final apiRepository = ref.watch(apiService);
    return apiRepository.getProducts(productFilterModel);
  },
);
final productDetailsProvider = FutureProvider.family<Product?, String>(
  (ref, productId) {
    final apiRepository = ref.watch(apiService);
    return apiRepository.getProductDetails(productId);
  },
);

final cartItemsProvider = StateNotifierProvider<CartNotifier, CartState>(
  (ref) => CartNotifier(ref.watch(apiService)),
);

final orderPaymentProvider =
    StateNotifierProvider<OrderPaymentNotifier, OrderPaymentState>(
  (ref) => OrderPaymentNotifier(ref.watch(apiService)),
);

final favoriteItemProvider =
    StateNotifierProvider<FavoriteNotifier, FavoriteState>(
        (ref) => FavoriteNotifier(ref.watch(apiService)));


        

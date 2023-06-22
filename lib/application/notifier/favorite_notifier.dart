import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_flutter/api/api_service.dart';
import 'package:grocery_flutter/application/state/favorite_state.dart';

class FavoriteNotifier extends StateNotifier<FavoriteState> {
  final ApiService apiService;
  FavoriteNotifier(this.apiService) : super(const FavoriteState()) {
    getFavoriteItem();
  }
  Future<void> getFavoriteItem() async {
    state = state.copyWith(isLoading: true);
    final favoriteData = await apiService.getFavorite();
     
    state = state.copyWith(favoriteModel: favoriteData);
    state = state.copyWith(isLoading: false);
  }

  Future<void> addFavoriteItem(productId) async {
   final favoriteData = await apiService.addFavorite(productId);
 
    await getFavoriteItem();
    state = state.copyWith(err: favoriteData);
  }

  Future<void> removeFavoriteItem(productId) async {
    await apiService.removeFavorite(productId);
    var isFavoriteExist = state.favoriteModel!.favorites
        .firstWhere((element) => element.product.productId == productId);
    var updatedItems = state.favoriteModel!;
    updatedItems.favorites.remove(isFavoriteExist);
    state = state.copyWith(favoriteModel: updatedItems);
  }
}

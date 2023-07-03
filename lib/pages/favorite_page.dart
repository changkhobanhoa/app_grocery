import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/favorite.dart';
import '/providers.dart';
import '/widgets/widget_favorite_item.dart';

 

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sản phẩm yêu thích"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: favoriteList(ref),
          )
        ],
      ),
    );
  }

  Widget favoriteList(WidgetRef ref) {
    final favoriteState = ref.watch(favoriteItemProvider);

    if (favoriteState.favoriteModel == null) {
      return const LinearProgressIndicator();
    }
    if (favoriteState.favoriteModel!.favorites.isEmpty) {
      return const Center(
        child: Text(
          'Favorite Empty',
        ),
      );
    }
    return buildFavoriteItem(favoriteState.favoriteModel!.favorites, ref);
  }

  Widget buildFavoriteItem(List<Favorite> cardFavorite, WidgetRef ref) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: cardFavorite.length,
        itemBuilder: (context, index) {
          return FavoriteItemWidget(
            model: cardFavorite[index],
            onItemRemove: (productId)   {
              final favoriteModel = ref.read(favoriteItemProvider.notifier);
                favoriteModel.removeFavoriteItem(productId);
           
            },
          );
        });
  }
}

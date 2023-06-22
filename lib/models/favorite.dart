import 'package:freezed_annotation/freezed_annotation.dart';

import 'product.dart';

part 'favorite.freezed.dart';
part 'favorite.g.dart';

@freezed
abstract class Favorite with _$Favorite {
  factory Favorite({required Product product}) = _Favorite;
  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
}

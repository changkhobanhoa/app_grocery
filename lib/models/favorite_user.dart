import 'package:freezed_annotation/freezed_annotation.dart';

import 'favorite.dart';


part 'favorite_user.freezed.dart';
part 'favorite_user.g.dart';

@unfreezed
abstract class FavoriteUser with _$FavoriteUser {
  factory FavoriteUser({required final String fullName,
  required final String email,
  required List<Favorite> favorites
  })=_FavoriteUser;

  factory FavoriteUser.fromJson(Map<String, dynamic> json)=>_$FavoriteUserFromJson(json);
}
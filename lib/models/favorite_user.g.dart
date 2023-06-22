// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FavoriteUser _$$_FavoriteUserFromJson(Map<String, dynamic> json) =>
    _$_FavoriteUser(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      favorites: (json['favorites'] as List<dynamic>)
          .map((e) => Favorite.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_FavoriteUserToJson(_$_FavoriteUser instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'favorites': instance.favorites,
    };

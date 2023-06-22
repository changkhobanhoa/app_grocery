// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavoriteUser _$FavoriteUserFromJson(Map<String, dynamic> json) {
  return _FavoriteUser.fromJson(json);
}

/// @nodoc
mixin _$FavoriteUser {
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  List<Favorite> get favorites => throw _privateConstructorUsedError;
  set favorites(List<Favorite> value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavoriteUserCopyWith<FavoriteUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteUserCopyWith<$Res> {
  factory $FavoriteUserCopyWith(
          FavoriteUser value, $Res Function(FavoriteUser) then) =
      _$FavoriteUserCopyWithImpl<$Res, FavoriteUser>;
  @useResult
  $Res call({String fullName, String email, List<Favorite> favorites});
}

/// @nodoc
class _$FavoriteUserCopyWithImpl<$Res, $Val extends FavoriteUser>
    implements $FavoriteUserCopyWith<$Res> {
  _$FavoriteUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? favorites = null,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      favorites: null == favorites
          ? _value.favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<Favorite>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FavoriteUserCopyWith<$Res>
    implements $FavoriteUserCopyWith<$Res> {
  factory _$$_FavoriteUserCopyWith(
          _$_FavoriteUser value, $Res Function(_$_FavoriteUser) then) =
      __$$_FavoriteUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fullName, String email, List<Favorite> favorites});
}

/// @nodoc
class __$$_FavoriteUserCopyWithImpl<$Res>
    extends _$FavoriteUserCopyWithImpl<$Res, _$_FavoriteUser>
    implements _$$_FavoriteUserCopyWith<$Res> {
  __$$_FavoriteUserCopyWithImpl(
      _$_FavoriteUser _value, $Res Function(_$_FavoriteUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? favorites = null,
  }) {
    return _then(_$_FavoriteUser(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      favorites: null == favorites
          ? _value.favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<Favorite>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FavoriteUser implements _FavoriteUser {
  _$_FavoriteUser(
      {required this.fullName, required this.email, required this.favorites});

  factory _$_FavoriteUser.fromJson(Map<String, dynamic> json) =>
      _$$_FavoriteUserFromJson(json);

  @override
  final String fullName;
  @override
  final String email;
  @override
  List<Favorite> favorites;

  @override
  String toString() {
    return 'FavoriteUser(fullName: $fullName, email: $email, favorites: $favorites)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavoriteUserCopyWith<_$_FavoriteUser> get copyWith =>
      __$$_FavoriteUserCopyWithImpl<_$_FavoriteUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavoriteUserToJson(
      this,
    );
  }
}

abstract class _FavoriteUser implements FavoriteUser {
  factory _FavoriteUser(
      {required final String fullName,
      required final String email,
      required List<Favorite> favorites}) = _$_FavoriteUser;

  factory _FavoriteUser.fromJson(Map<String, dynamic> json) =
      _$_FavoriteUser.fromJson;

  @override
  String get fullName;
  @override
  String get email;
  @override
  List<Favorite> get favorites;
  set favorites(List<Favorite> value);
  @override
  @JsonKey(ignore: true)
  _$$_FavoriteUserCopyWith<_$_FavoriteUser> get copyWith =>
      throw _privateConstructorUsedError;
}

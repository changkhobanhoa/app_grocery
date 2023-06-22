// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FavoriteState {
  FavoriteUser? get favoriteModel => throw _privateConstructorUsedError;
  String? get err => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FavoriteStateCopyWith<FavoriteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteStateCopyWith<$Res> {
  factory $FavoriteStateCopyWith(
          FavoriteState value, $Res Function(FavoriteState) then) =
      _$FavoriteStateCopyWithImpl<$Res, FavoriteState>;
  @useResult
  $Res call({FavoriteUser? favoriteModel, String? err, bool isLoading});

  $FavoriteUserCopyWith<$Res>? get favoriteModel;
}

/// @nodoc
class _$FavoriteStateCopyWithImpl<$Res, $Val extends FavoriteState>
    implements $FavoriteStateCopyWith<$Res> {
  _$FavoriteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteModel = freezed,
    Object? err = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      favoriteModel: freezed == favoriteModel
          ? _value.favoriteModel
          : favoriteModel // ignore: cast_nullable_to_non_nullable
              as FavoriteUser?,
      err: freezed == err
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FavoriteUserCopyWith<$Res>? get favoriteModel {
    if (_value.favoriteModel == null) {
      return null;
    }

    return $FavoriteUserCopyWith<$Res>(_value.favoriteModel!, (value) {
      return _then(_value.copyWith(favoriteModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FavoriteStateCopyWith<$Res>
    implements $FavoriteStateCopyWith<$Res> {
  factory _$$_FavoriteStateCopyWith(
          _$_FavoriteState value, $Res Function(_$_FavoriteState) then) =
      __$$_FavoriteStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FavoriteUser? favoriteModel, String? err, bool isLoading});

  @override
  $FavoriteUserCopyWith<$Res>? get favoriteModel;
}

/// @nodoc
class __$$_FavoriteStateCopyWithImpl<$Res>
    extends _$FavoriteStateCopyWithImpl<$Res, _$_FavoriteState>
    implements _$$_FavoriteStateCopyWith<$Res> {
  __$$_FavoriteStateCopyWithImpl(
      _$_FavoriteState _value, $Res Function(_$_FavoriteState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteModel = freezed,
    Object? err = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$_FavoriteState(
      favoriteModel: freezed == favoriteModel
          ? _value.favoriteModel
          : favoriteModel // ignore: cast_nullable_to_non_nullable
              as FavoriteUser?,
      err: freezed == err
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_FavoriteState implements _FavoriteState {
  const _$_FavoriteState(
      {this.favoriteModel, this.err, this.isLoading = false});

  @override
  final FavoriteUser? favoriteModel;
  @override
  final String? err;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'FavoriteState(favoriteModel: $favoriteModel, err: $err, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavoriteState &&
            (identical(other.favoriteModel, favoriteModel) ||
                other.favoriteModel == favoriteModel) &&
            (identical(other.err, err) || other.err == err) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, favoriteModel, err, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavoriteStateCopyWith<_$_FavoriteState> get copyWith =>
      __$$_FavoriteStateCopyWithImpl<_$_FavoriteState>(this, _$identity);
}

abstract class _FavoriteState implements FavoriteState {
  const factory _FavoriteState(
      {final FavoriteUser? favoriteModel,
      final String? err,
      final bool isLoading}) = _$_FavoriteState;

  @override
  FavoriteUser? get favoriteModel;
  @override
  String? get err;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_FavoriteStateCopyWith<_$_FavoriteState> get copyWith =>
      throw _privateConstructorUsedError;
}

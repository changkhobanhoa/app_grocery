// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$userState {
  Data? get userModel => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $userStateCopyWith<userState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $userStateCopyWith<$Res> {
  factory $userStateCopyWith(userState value, $Res Function(userState) then) =
      _$userStateCopyWithImpl<$Res, userState>;
  @useResult
  $Res call({Data? userModel, bool isLoading});
}

/// @nodoc
class _$userStateCopyWithImpl<$Res, $Val extends userState>
    implements $userStateCopyWith<$Res> {
  _$userStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userModel = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      userModel: freezed == userModel
          ? _value.userModel
          : userModel // ignore: cast_nullable_to_non_nullable
              as Data?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_userStateCopyWith<$Res> implements $userStateCopyWith<$Res> {
  factory _$$_userStateCopyWith(
          _$_userState value, $Res Function(_$_userState) then) =
      __$$_userStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Data? userModel, bool isLoading});
}

/// @nodoc
class __$$_userStateCopyWithImpl<$Res>
    extends _$userStateCopyWithImpl<$Res, _$_userState>
    implements _$$_userStateCopyWith<$Res> {
  __$$_userStateCopyWithImpl(
      _$_userState _value, $Res Function(_$_userState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userModel = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$_userState(
      userModel: freezed == userModel
          ? _value.userModel
          : userModel // ignore: cast_nullable_to_non_nullable
              as Data?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_userState implements _userState {
  const _$_userState({this.userModel, this.isLoading = false});

  @override
  final Data? userModel;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'userState(userModel: $userModel, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_userState &&
            (identical(other.userModel, userModel) ||
                other.userModel == userModel) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userModel, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_userStateCopyWith<_$_userState> get copyWith =>
      __$$_userStateCopyWithImpl<_$_userState>(this, _$identity);
}

abstract class _userState implements userState {
  const factory _userState({final Data? userModel, final bool isLoading}) =
      _$_userState;

  @override
  Data? get userModel;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_userStateCopyWith<_$_userState> get copyWith =>
      throw _privateConstructorUsedError;
}

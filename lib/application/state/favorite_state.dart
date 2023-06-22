import 'package:freezed_annotation/freezed_annotation.dart';
import '/models/favorite_user.dart';

part 'favorite_state.freezed.dart';

@freezed
class FavoriteState with _$FavoriteState {
  const factory FavoriteState({
    FavoriteUser? favoriteModel,
    String? err,
    @Default(false) bool isLoading,
  }) = _FavoriteState;
}

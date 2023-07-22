import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/login_response_model.dart';

part 'user_state.freezed.dart';

@freezed
class userState with _$userState {
  const factory userState({
    Data? userModel,
    @Default(false) bool isLoading,
  }) = _userState;
}

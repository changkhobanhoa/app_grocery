import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.model.freezed.dart';
part 'user.model.g.dart';

List<UserModel> userFromJson(dynamic json) =>
    List<UserModel>.from((json).map((e) => UserModel.fromJson(e)));

@freezed
abstract class UserModel with _$UserModel {
  factory UserModel({
    required String userId,
    required String fullName,
    required String email,
    required String token,
  }) = _User;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

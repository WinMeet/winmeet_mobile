// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request_model.freezed.dart';
part 'register_request_model.g.dart';

@freezed
class RegisterRequestModel with _$RegisterRequestModel {
  const factory RegisterRequestModel({
    @JsonKey(name: 'userName') required String name,
    @JsonKey(name: 'userSurname') required String surname,
    @JsonKey(name: 'userEmail') required String email,
    @JsonKey(name: 'userPassword') required String password,
  }) = _RegisterRequestModel;

  const RegisterRequestModel._();

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => _$RegisterRequestModelFromJson(json);
}

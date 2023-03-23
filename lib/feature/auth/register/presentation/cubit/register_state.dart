part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(FormzStatus.pure) FormzStatus status,
    @Default(InputField.pure()) InputField name,
    @Default(Email.pure()) Email email,
    @Default(Password.pure()) Password password,
    @Default(ConfirmPassword.pure()) ConfirmPassword confirmPassword,
    @Default(true) bool isPasswordObscured,
    String? errorMessage,
  }) = _RegisterState;
}

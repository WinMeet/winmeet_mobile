part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(FormzStatus.pure) FormzStatus status,
    @Default(EmailFormInput.pure()) EmailFormInput email,
    @Default(PasswordFormInput.pure()) PasswordFormInput password,
    @Default(true) bool isPasswordObscured,
    String? errorMessage,
  }) = _LoginState;
}

part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required FormzStatus status,
    required EmailFormInput email,
    required PasswordFormInput password,
    required bool isPasswordObscured,
    String? errorMessage,
  }) = _LoginState;

  factory LoginState.initial() => const LoginState(
        status: FormzStatus.pure,
        email: EmailFormInput.pure(),
        password: PasswordFormInput.pure(),
        isPasswordObscured: true,
      );
}

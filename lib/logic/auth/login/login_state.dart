part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(FormzStatus.pure) FormzStatus status,
    @Default(Email.pure()) Email email,
    @Default(Password.pure()) Password password,
    @Default(true) bool isPasswordObscured,
    String? errorMessage,
  }) = _LoginState;
}

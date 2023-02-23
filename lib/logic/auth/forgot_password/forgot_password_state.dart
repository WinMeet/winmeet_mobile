part of 'forgot_password_cubit.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default(FormzStatus.pure) FormzStatus status,
    @Default(Email.pure()) Email email,
    String? errorMessage,
  }) = _ForgotPasswordState;
}

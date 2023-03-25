part of 'forgot_password_cubit.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default(FormzStatus.pure) FormzStatus status,
    @Default(EmailFormInput.pure()) EmailFormInput email,
    String? errorMessage,
  }) = _ForgotPasswordState;
}

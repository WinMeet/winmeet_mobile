part of 'forgot_password_cubit.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    required FormzStatus status,
    required EmailFormInput email,
  }) = _ForgotPasswordState;

  factory ForgotPasswordState.initial() => const ForgotPasswordState(
        status: FormzStatus.pure,
        email: EmailFormInput.pure(),
      );
}

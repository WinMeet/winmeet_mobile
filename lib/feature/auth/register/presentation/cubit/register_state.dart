part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    required FormzStatus status,
    required InputFormField name,
    required EmailFormInput email,
    required PasswordFormInput password,
    required ConfirmPasswordFormInput confirmPassword,
    required bool isPasswordObscured,
    String? errorMessage,
  }) = _RegisterState;

  factory RegisterState.initial() => const RegisterState(
        status: FormzStatus.pure,
        name: InputFormField.pure(),
        email: EmailFormInput.pure(),
        password: PasswordFormInput.pure(),
        confirmPassword: ConfirmPasswordFormInput.pure(),
        isPasswordObscured: true,
      );
}

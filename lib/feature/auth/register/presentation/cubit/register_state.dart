part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(FormzStatus.pure) FormzStatus status,
    @Default(InputFormField.pure()) InputFormField name,
    @Default(EmailFormInput.pure()) EmailFormInput email,
    @Default(PasswordFormInput.pure()) PasswordFormInput password,
    @Default(ConfirmPasswordFormInput.pure()) ConfirmPasswordFormInput confirmPassword,
    @Default(true) bool isPasswordObscured,
    String? errorMessage,
  }) = _RegisterState;
}

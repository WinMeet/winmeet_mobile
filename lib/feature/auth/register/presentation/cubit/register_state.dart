part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    required FormzStatus status,
    required InputFormField name,
    required InputFormField surname,
    required EmailFormInput email,
    required PasswordFormInput password,
    required bool isPasswordObscured,
  }) = _RegisterState;

  factory RegisterState.initial() => const RegisterState(
        status: FormzStatus.pure,
        name: InputFormField.pure(),
        surname: InputFormField.pure(),
        email: EmailFormInput.pure(),
        password: PasswordFormInput.pure(),
        isPasswordObscured: true,
      );
}

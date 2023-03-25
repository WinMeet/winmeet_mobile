import 'package:formz/formz.dart';

enum PasswordFormInputError {
  weakPassword,
}

class PasswordFormInput extends FormzInput<String, PasswordFormInputError> {
  const PasswordFormInput.pure() : super.pure('');

  const PasswordFormInput.dirty([super.value = '']) : super.dirty();
  @override
  PasswordFormInputError? validator(String value) {
    return RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$').hasMatch(value.trim())
        ? null
        : PasswordFormInputError.weakPassword;
  }
}

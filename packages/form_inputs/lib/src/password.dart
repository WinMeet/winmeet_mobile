import 'package:formz/formz.dart';

enum PasswordInputError {
  weakPassword,
}

class Password extends FormzInput<String, PasswordInputError> {
  const Password.pure() : super.pure('');

  const Password.dirty([super.value = '']) : super.dirty();
  @override
  PasswordInputError? validator(String value) {
    return RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$').hasMatch(value.trim())
        ? null
        : PasswordInputError.weakPassword;
  }
}

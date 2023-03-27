import 'package:formz/formz.dart';

enum ConfirmPasswordFormInputError {
  passwordsDoNotMatch,
}

class ConfirmPasswordFormInput extends FormzInput<String, ConfirmPasswordFormInputError> {
  const ConfirmPasswordFormInput.pure({this.password = ''}) : super.pure('');

  const ConfirmPasswordFormInput.dirty({required this.password, String value = ''}) : super.dirty(value);

  final String password;

  @override
  ConfirmPasswordFormInputError? validator(String? value) {
    return password == value ? null : ConfirmPasswordFormInputError.passwordsDoNotMatch;
  }
}

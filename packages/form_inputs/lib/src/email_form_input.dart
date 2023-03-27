import 'package:formz/formz.dart';

enum EmailFormInputError {
  invalidEmail,
}

class EmailFormInput extends FormzInput<String, EmailFormInputError> {
  const EmailFormInput.pure() : super.pure('');

  const EmailFormInput.dirty([super.value = '']) : super.dirty();
  @override
  EmailFormInputError? validator(String value) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim()) ? null : EmailFormInputError.invalidEmail;
  }
}

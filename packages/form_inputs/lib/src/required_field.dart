import 'package:formz/formz.dart';

enum RequiredFieldInputError {
  inValidInput,
}

class RequiredField extends FormzInput<String, RequiredFieldInputError> {
  const RequiredField.pure() : super.pure('');

  const RequiredField.dirty([super.value = '']) : super.dirty();
  @override
  RequiredFieldInputError? validator(String value) {
    return value.trim().isEmpty ? RequiredFieldInputError.inValidInput : null;
  }
}

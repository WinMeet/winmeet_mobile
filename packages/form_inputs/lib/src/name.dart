import 'package:formz/formz.dart';

enum NameInputError {
  inValidName,
}

class Name extends FormzInput<String, NameInputError> {
  const Name.pure() : super.pure('');

  const Name.dirty([super.value = '']) : super.dirty();
  @override
  NameInputError? validator(String value) {
    return value.trim().isEmpty ? NameInputError.inValidName : null;
  }
}

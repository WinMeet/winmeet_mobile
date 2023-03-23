import 'package:formz/formz.dart';

enum InputFieldError {
  invalidInput,
}

class InputField extends FormzInput<String, InputFieldError> {
  const InputField.pure({this.isRequired = true}) : super.pure('');

  const InputField.dirty({required String value, this.isRequired = true}) : super.dirty(value);

  final bool isRequired;

  @override
  InputFieldError? validator(String value) {
    if (isRequired) {
      return value.trim().isEmpty ? InputFieldError.invalidInput : null;
    } else {
      return null;
    }
  }
}

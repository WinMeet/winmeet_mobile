import 'package:formz/formz.dart';

enum InputFormFieldError {
  emptyFieldError,
}

class InputFormField extends FormzInput<String, InputFormFieldError> {
  const InputFormField.pure({this.isRequired = true}) : super.pure('');

  const InputFormField.dirty({required String value, this.isRequired = true}) : super.dirty(value);

  final bool isRequired;

  @override
  InputFormFieldError? validator(String value) {
    if (isRequired) {
      return value.trim().isEmpty ? InputFormFieldError.emptyFieldError : null;
    } else {
      return null;
    }
  }
}

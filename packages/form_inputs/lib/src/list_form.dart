import 'package:formz/formz.dart';

enum ListFormError {
  emptyList,
}

class ListFormValidator<T> extends FormzInput<List<T>, ListFormError> {
  ListFormValidator.pure() : super.pure([]);

  ListFormValidator.dirty([super.value = const []]) : super.dirty();
  @override
  ListFormError? validator(List<T> value) {
    return value.isEmpty ? ListFormError.emptyList : null;
  }

  @override
  String toString() {
    return value.toString();
  }
}

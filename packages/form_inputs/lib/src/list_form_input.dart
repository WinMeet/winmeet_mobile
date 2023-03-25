import 'package:formz/formz.dart';

enum ListFormInputError {
  emptyList,
}

class ListFormInput<T> extends FormzInput<List<T>, ListFormInputError> {
  ListFormInput.pure() : super.pure([]);

  ListFormInput.dirty([super.value = const []]) : super.dirty();
  @override
  ListFormInputError? validator(List<T> value) {
    return value.isEmpty ? ListFormInputError.emptyList : null;
  }

  @override
  String toString() {
    return value.toString();
  }
}

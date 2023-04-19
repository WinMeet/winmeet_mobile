import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:winmeet_mobile/feature/auth/register/data/model/register_request_model.dart';
import 'package:winmeet_mobile/feature/auth/register/data/repository/register_repository.dart';

part 'register_cubit.freezed.dart';
part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required RegisterRepository registerRepository})
      : _registerRepository = registerRepository,
        super(RegisterState.initial());

  final RegisterRepository _registerRepository;

  void nameChanged({required String name}) {
    final newName = InputFormField.dirty(value: name);
    emit(
      state.copyWith(
        name: newName,
        status: Formz.validate([
          newName,
          state.surname,
          state.email,
          state.password,
        ]),
      ),
    );
  }

  void surnameChanged({required String surname}) {
    final newSurname = InputFormField.dirty(value: surname);
    emit(
      state.copyWith(
        surname: newSurname,
        status: Formz.validate([
          state.name,
          newSurname,
          state.email,
          state.password,
        ]),
      ),
    );
  }

  void emailChanged({required String email}) {
    final newEmail = EmailFormInput.dirty(email);
    emit(
      state.copyWith(
        email: newEmail,
        status: Formz.validate(
          [
            newEmail,
            state.name,
            state.surname,
            state.password,
          ],
        ),
      ),
    );
  }

  void passwordChanged({required String password}) {
    final newPassword = PasswordFormInput.dirty(password);

    emit(
      state.copyWith(
        password: newPassword,
        status: Formz.validate([
          state.name,
          state.surname,
          state.email,
          newPassword,
        ]),
      ),
    );
  }

  void passwordVisibilityChanged() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  Future<void> formSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _registerRepository.registerWithEmailAndPassword(
        registerRequestModel: RegisterRequestModel(
          name: state.name.value,
          surname: state.surname.value,
          email: state.email.value,
          password: state.password.value,
        ),
      );
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}

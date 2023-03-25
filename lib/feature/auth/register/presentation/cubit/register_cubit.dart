import 'package:bloc/bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/exceptions/auth_exceptions.dart';

import 'package:winmeet_mobile/feature/auth/register/data/model/register_request_model.dart';
import 'package:winmeet_mobile/feature/auth/register/data/repository/register_repository.dart';

part 'register_cubit.freezed.dart';
part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required RegisterRepository registerRepository})
      : _registerRepository = registerRepository,
        super(const RegisterState());

  final RegisterRepository _registerRepository;

  void nameChanged({required String name}) {
    final newName = InputFormField.dirty(value: name);
    emit(
      state.copyWith(
        name: newName,
        status: Formz.validate([
          newName,
          state.email,
          state.password,
          state.confirmPassword,
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
            state.password,
            state.confirmPassword,
          ],
        ),
      ),
    );
  }

  void passwordChanged({required String password}) {
    final newPassword = PasswordFormInput.dirty(password);
    final confirmPassword = ConfirmPasswordFormInput.dirty(
      password: newPassword.value,
      value: state.confirmPassword.value,
    );
    emit(
      state.copyWith(
        password: newPassword,
        status: Formz.validate([
          state.name,
          state.email,
          newPassword,
          confirmPassword,
        ]),
      ),
    );
  }

  void confirmPasswordChanged({required String confirmPassword}) {
    final newConfirmPassword = ConfirmPasswordFormInput.dirty(
      password: state.password.value,
      value: confirmPassword,
    );

    emit(
      state.copyWith(
        confirmPassword: newConfirmPassword,
        status: Formz.validate([
          state.name,
          state.email,
          state.password,
          newConfirmPassword,
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
          email: state.email.value,
          password: state.password.value,
        ),
      );
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
        ),
      );
    } on RegisterWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.message,
        ),
      );
    }
  }
}

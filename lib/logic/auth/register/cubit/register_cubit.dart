import 'package:bloc/bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:winmeet_mobile/app/exceptions/auth_exceptions.dart';
import 'package:winmeet_mobile/data/repositories/auth/base_auth_repository.dart';

part 'register_cubit.freezed.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required BaseAuthRepository authRepository})
      : _authRepository = authRepository,
        super(const RegisterState());

  final BaseAuthRepository _authRepository;

  void emailChanged({required String email}) {
    final newEmail = Email.dirty(email);
    emit(state.copyWith(email: newEmail, status: Formz.validate([newEmail, state.password])));
  }

  void passwordChanged({required String password}) {
    final newPassword = Password.dirty(password);
    final confirmPassword = ConfirmPassword.dirty(
      password: newPassword.value,
      value: state.confirmPassword.value,
    );
    emit(
      state.copyWith(
        password: newPassword,
        status: Formz.validate([
          state.email,
          newPassword,
          confirmPassword,
        ]),
      ),
    );
  }

  void confirmPasswordChanged({required String confirmPassword}) {
    final newConfirmPassword = ConfirmPassword.dirty(
      password: state.password.value,
      value: confirmPassword,
    );

    emit(
      state.copyWith(
        confirmPassword: newConfirmPassword,
        status: Formz.validate([
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
      await _authRepository.registerWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
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

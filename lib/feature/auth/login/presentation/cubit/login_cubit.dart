import 'package:bloc/bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/exceptions/auth_exceptions.dart';
import 'package:winmeet_mobile/feature/auth/login/data/model/login_request_model.dart';
import 'package:winmeet_mobile/feature/auth/login/data/repository/login_repository.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required LoginRepository loginRepository})
      : _loginRepository = loginRepository,
        super(const LoginState());

  final LoginRepository _loginRepository;

  void emailChanged({required String email}) {
    final newEmail = Email.dirty(email);
    emit(state.copyWith(email: newEmail, status: Formz.validate([newEmail, state.password])));
  }

  void passwordChanged({required String password}) {
    final newPassword = Password.dirty(password);
    emit(state.copyWith(password: newPassword, status: Formz.validate([newPassword, state.email])));
  }

  void passwordVisibilityChanged() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  Future<void> formSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await _loginRepository.loginWithEmailAndPassword(
        loginRequestModel: LoginRequestModel(
          email: state.email.value,
          password: state.password.value,
        ),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LoginWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(errorMessage: e.message, status: FormzStatus.submissionFailure));
    }
  }
}

// ignore_for_file: require_trailing_commas

import 'package:bloc/bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:winmeet_mobile/app/exceptions/auth_exceptions.dart';
import 'package:winmeet_mobile/data/repositories/auth/base_auth_repository.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required BaseAuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState()) {
    on<_EmailChanged>(_onEmailChanged);
    on<_PasswordChanged>(_onPasswordChanged);
    on<_PasswordVisibilityChanged>(_onPasswordVisibilityChanged);
    on<_FormSubmitted>(_onFormSubmitted);
  }
  final BaseAuthRepository _authRepository;

  void _onEmailChanged(_EmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email, status: Formz.validate([email, state.password])));
  }

  void _onPasswordChanged(_PasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password, status: Formz.validate([password, state.email])));
  }

  void _onPasswordVisibilityChanged(_PasswordVisibilityChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  Future<void> _onFormSubmitted(_FormSubmitted event, Emitter<LoginState> emit) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      await _authRepository.registerWithEmailAndPassword(email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LoginWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(errorMessage: e.message, status: FormzStatus.submissionFailure));
    }
  }
}

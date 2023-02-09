import 'package:bloc/bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:winmeet_mobile/app/exceptions/auth_exceptions.dart';
import 'package:winmeet_mobile/data/repositories/auth/base_auth_repository.dart';

part 'forgot_password_bloc.freezed.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({required BaseAuthRepository authRepository})
      : _authRepository = authRepository,
        super(const ForgotPasswordState()) {
    on<_EmailChanged>(_onEmailChanged);
    on<_FormSubmitted>(_onFormSubmitted);
  }
  final BaseAuthRepository _authRepository;

  void _onEmailChanged(_EmailChanged event, Emitter<ForgotPasswordState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email, status: Formz.validate([email])));
  }

  Future<void> _onFormSubmitted(
    _FormSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepository.sendPasswordResetEmail(email: state.email.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on PasswordResetFailure catch (e) {
      emit(state.copyWith(errorMessage: e.message, status: FormzStatus.submissionFailure));
    }
  }
}

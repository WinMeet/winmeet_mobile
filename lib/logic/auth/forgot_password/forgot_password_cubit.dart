import 'package:bloc/bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/exceptions/auth_exceptions.dart';
import 'package:winmeet_mobile/data/repositories/auth/base_auth_repository.dart';

part 'forgot_password_cubit.freezed.dart';
part 'forgot_password_state.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit({required BaseAuthRepository authRepository})
      : _authRepository = authRepository,
        super(const ForgotPasswordState());

  final BaseAuthRepository _authRepository;

  void emailChanged({required String email}) {
    final newEmail = Email.dirty(email);
    emit(state.copyWith(email: newEmail, status: Formz.validate([newEmail])));
  }

  Future<void> formSubmitted() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepository.sendPasswordResetEmail(email: state.email.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on PasswordResetFailure catch (e) {
      emit(state.copyWith(errorMessage: e.message, status: FormzStatus.submissionFailure));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/enums/form_status.dart';
import '../../../app/exceptions/auth_exceptions.dart';
import '../../../../core/utility/input_validator/input_validator.dart';
import '../../../../data/repositories/auth/base_auth_repository.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required this.authRepository,
  }) : super(const RegisterState()) {
    on<_EmailChanged>(_onEmailChanged);
    on<_PasswordChanged>(_onPasswordChanged);
    on<_PasswordVisibilityChanged>(_onPasswordVisibilityChanged);
    on<_RegisterSubmitted>(_onRegisterSubmitted);
  }
  final BaseAuthRepository authRepository;

  void _onEmailChanged(_EmailChanged event, Emitter<RegisterState> emit) {
    InputValidator.checkEmailValidity(event.email)
        ? emit(state.copyWith(email: event.email, isValidEmail: true))
        : emit(state.copyWith(email: event.email, isValidEmail: false));
  }

  void _onPasswordChanged(_PasswordChanged event, Emitter<RegisterState> emit) {
    InputValidator.checkPasswordValidity(event.password)
        ? emit(state.copyWith(password: event.password, isValidPassword: true))
        : emit(state.copyWith(password: event.password, isValidPassword: false));
  }

  void _onPasswordVisibilityChanged(_PasswordVisibilityChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  Future<void> _onRegisterSubmitted(_RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(status: FormStatus.submitting));
    try {
      await authRepository.registerWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: FormStatus.success));
      emit(state.copyWith(status: FormStatus.initial));
    } on RegisterWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(errorMessage: e.message, status: FormStatus.failure));
      emit(state.copyWith(status: FormStatus.initial));
    }
  }
}

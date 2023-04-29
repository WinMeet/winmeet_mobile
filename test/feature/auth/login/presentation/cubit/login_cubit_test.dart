import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:mocktail/mocktail.dart';

import 'package:winmeet_mobile/core/model/failure/failure_model.dart';
import 'package:winmeet_mobile/feature/auth/login/data/model/login_request_model.dart';
import 'package:winmeet_mobile/feature/auth/login/data/repository/login_repository.dart';
import 'package:winmeet_mobile/feature/auth/login/presentation/cubit/login_cubit.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late LoginRepository loginRepository;
  late LoginCubit cubit;

  setUp(() {
    loginRepository = MockLoginRepository();
    cubit = LoginCubit(loginRepository: loginRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('LoginCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, LoginState.initial());
    });

    const email = 'test@test.com';
    const password = 'Test1234';

    blocTest<LoginCubit, LoginState>(
      'emits new state when email is changed',
      build: () => cubit,
      act: (cubit) => cubit.emailChanged(email: email),
      expect: () => [
        const LoginState(
          email: EmailFormInput.dirty(email),
          password: PasswordFormInput.pure(),
          isPasswordObscured: true,
          status: FormzStatus.invalid,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits new state when password is changed',
      build: () => cubit,
      act: (cubit) => cubit.passwordChanged(password: password),
      expect: () => [
        const LoginState(
          email: EmailFormInput.pure(),
          password: PasswordFormInput.dirty(password),
          isPasswordObscured: true,
          status: FormzStatus.invalid,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits new state when password visibility is changed',
      build: () => cubit,
      act: (cubit) => cubit.passwordVisibilityChanged(),
      expect: () => [
        const LoginState(
          email: EmailFormInput.pure(),
          password: PasswordFormInput.pure(),
          isPasswordObscured: false,
          status: FormzStatus.pure,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits submissionInProgress and submissionFailure when formSubmitted fails',
      build: () {
        when(
          () => loginRepository.loginWithEmailAndPassword(
            loginRequestModel: const LoginRequestModel(
              email: email,
              password: password,
            ),
          ),
        ).thenAnswer((_) async => left(const FailureModel()));
        return cubit;
      },
      seed: () => const LoginState(
        email: EmailFormInput.dirty(email),
        password: PasswordFormInput.dirty(password),
        isPasswordObscured: true,
        status: FormzStatus.valid,
      ),
      act: (cubit) => cubit.formSubmitted(),
      expect: () => [
        const LoginState(
          email: EmailFormInput.dirty(email),
          password: PasswordFormInput.dirty(password),
          isPasswordObscured: true,
          status: FormzStatus.submissionInProgress,
        ),
        const LoginState(
          email: EmailFormInput.dirty(email),
          password: PasswordFormInput.dirty(password),
          isPasswordObscured: true,
          status: FormzStatus.submissionFailure,
        ),
      ],
    );
  });
}

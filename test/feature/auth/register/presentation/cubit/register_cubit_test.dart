import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:mocktail/mocktail.dart';
import 'package:winmeet_mobile/feature/auth/register/data/repository/register_repository.dart';
import 'package:winmeet_mobile/feature/auth/register/presentation/cubit/register_cubit.dart';

class MockRegisterRepository extends Mock implements RegisterRepository {}

void main() {
  late RegisterRepository registerRepository;
  late RegisterCubit registerCubit;

  const name = 'TestName';
  const surname = 'TestSurname';
  const email = 'test@test.com';
  const password = 'Test1234';

  setUp(() {
    registerRepository = MockRegisterRepository();
    registerCubit = RegisterCubit(registerRepository: registerRepository);
  });

  group('RegisterCubit', () {
    test('initial state is correct', () {
      expect(registerCubit.state.name.value, equals(''));
      expect(registerCubit.state.surname.value, equals(''));
      expect(registerCubit.state.email.value, equals(''));
      expect(registerCubit.state.password.value, equals(''));
      expect(registerCubit.state.isPasswordObscured, equals(true));
      expect(registerCubit.state.status, equals(FormzStatus.pure));
    });

    test('nameChanged updates name value and form status', () {
      registerCubit.nameChanged(name: name);
      expect(registerCubit.state.name.value, equals(name));
      expect(registerCubit.state.status.isValid, equals(false));
    });

    test('surnameChanged updates surname value and form status', () {
      registerCubit.surnameChanged(surname: surname);
      expect(registerCubit.state.surname.value, equals(surname));
      expect(registerCubit.state.status.isValid, equals(false));
    });

    test('emailChanged updates email value and form status', () {
      registerCubit.emailChanged(email: email);
      expect(registerCubit.state.email.value, equals(email));
      expect(registerCubit.state.status.isValid, equals(false));
    });

    test('passwordChanged updates password value and form status', () {
      registerCubit.passwordChanged(password: password);
      expect(registerCubit.state.password.value, equals(password));
      expect(registerCubit.state.status.isValid, equals(false));
    });

    test('passwordVisibilityChanged toggles isPasswordObscured', () {
      expect(registerCubit.state.isPasswordObscured, equals(true));
      registerCubit.passwordVisibilityChanged();
      expect(registerCubit.state.isPasswordObscured, equals(false));
      registerCubit.passwordVisibilityChanged();
      expect(registerCubit.state.isPasswordObscured, equals(true));
    });
  });
}

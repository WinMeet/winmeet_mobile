// ignore_for_file: inference_failure_on_function_invocation, avoid_returning_null_for_void

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:winmeet_mobile/core/model/failure/failure_model.dart';
import 'package:winmeet_mobile/feature/auth/register/data/api/register_api.dart';
import 'package:winmeet_mobile/feature/auth/register/data/model/register_request_model.dart';
import 'package:winmeet_mobile/feature/auth/register/data/repository/register_repository.dart';

class MockRegisterApi extends Mock implements RegisterApi {}

void main() {
  late RegisterApi registerApi;
  late RegisterRepository registerRepository;

  const name = 'TestName';
  const surname = 'TestSurname';
  const email = 'test@test.com';
  const password = 'Test1234';

  setUp(() {
    registerApi = MockRegisterApi();
    registerRepository = RegisterRepository(registerApi: registerApi);
  });

  group('RegisterRepository', () {
    test('registerWithEmailAndPassword returns Right on success', () async {
      const registerRequestModel = RegisterRequestModel(
        name: name,
        surname: surname,
        email: email,
        password: password,
      );

      when(() => registerApi.registerWithEmailAndPassword(registerRequestModel: registerRequestModel))
          .thenAnswer((_) async => null);

      final result = await registerRepository.registerWithEmailAndPassword(registerRequestModel: registerRequestModel);

      expect(result, equals(right(null)));
    });

    test('registerWithEmailAndPassword returns Left on failure', () async {
      const registerRequestModel = RegisterRequestModel(
        name: name,
        surname: surname,
        email: email,
        password: password,
      );

      when(() => registerApi.registerWithEmailAndPassword(registerRequestModel: registerRequestModel))
          .thenThrow(Exception('Network error'));

      final result = await registerRepository.registerWithEmailAndPassword(registerRequestModel: registerRequestModel);

      expect(result, equals(left(const FailureModel())));
    });
  });
}

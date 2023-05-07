// ignore_for_file: inference_failure_on_function_invocation

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:winmeet_mobile/app/constants/cache_contants.dart';

import 'package:winmeet_mobile/core/clients/cache/cache_client.dart';
import 'package:winmeet_mobile/core/model/failure/failure_model.dart';
import 'package:winmeet_mobile/feature/auth/login/data/api/login_api.dart';
import 'package:winmeet_mobile/feature/auth/login/data/model/login_request_model.dart';
import 'package:winmeet_mobile/feature/auth/login/data/model/token_model.dart';
import 'package:winmeet_mobile/feature/auth/login/data/repository/login_repository.dart';

class MockLoginApi extends Mock implements LoginApi {}

class MockCacheClient extends Mock implements CacheClient {}

void main() {
  late LoginApi loginApi;
  late CacheClient cacheClient;
  late LoginRepository loginRepository;

  setUp(() {
    loginApi = MockLoginApi();
    cacheClient = MockCacheClient();
    loginRepository = LoginRepository(loginApi: loginApi, cacheClient: cacheClient);
  });

  group('LoginRepository', () {
    const loginRequestModel = LoginRequestModel(email: 'test@test.com', password: 'Test1234');
    const tokenModel = TokenModel(token: 'token');

    test('loginWithEmailAndPassword returns Right on successful login', () async {
      when(() => loginApi.loginWithEmailAndPassword(loginRequestModel: loginRequestModel))
          .thenAnswer((_) async => tokenModel);
      when(() => cacheClient.setString(CacheConstants.token, tokenModel.token)).thenAnswer((_) async => true);

      final result = await loginRepository.loginWithEmailAndPassword(loginRequestModel: loginRequestModel);

      expect(result, right(true));
      verify(() => cacheClient.setString(CacheConstants.token, tokenModel.token)).called(1);
    });

    test('loginWithEmailAndPassword returns Left on failed login', () async {
      when(() => loginApi.loginWithEmailAndPassword(loginRequestModel: loginRequestModel)).thenThrow(Exception());

      final result = await loginRepository.loginWithEmailAndPassword(loginRequestModel: loginRequestModel);

      expect(result, left(const FailureModel()));
    });
  });
}

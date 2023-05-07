import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:winmeet_mobile/app/constants/endpoints.dart';

import 'package:winmeet_mobile/core/clients/network/network_client.dart';
import 'package:winmeet_mobile/feature/auth/login/data/api/login_api.dart';
import 'package:winmeet_mobile/feature/auth/login/data/model/login_request_model.dart';
import 'package:winmeet_mobile/feature/auth/login/data/model/token_model.dart';

class MockNetworkClient extends Mock implements NetworkClient {}

void main() {
  late NetworkClient networkClient;
  late LoginApi loginApi;
  const email = 'test@test.com';
  const password = 'Test1234';

  setUp(() {
    networkClient = MockNetworkClient();
    loginApi = LoginApi(networkClient: networkClient);
  });

  group('LoginApi', () {
    test('loginWithEmailAndPassword returns a TokenModel on successful login', () async {
      const expectedTokenModel = TokenModel(token: 'token');

      when(
        () => networkClient.post<Map<String, dynamic>>(
          Endpoints.login,
          data: const LoginRequestModel(
            email: email,
            password: password,
          ).toJson(),
        ),
      ).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: {'token': 'token'},
          requestOptions: RequestOptions(),
          statusCode: 200,
        ),
      );

      final actualTokenModel = await loginApi.loginWithEmailAndPassword(
        loginRequestModel: const LoginRequestModel(
          email: email,
          password: password,
        ),
      );

      expect(actualTokenModel, expectedTokenModel);
    });

    test('loginWithEmailAndPassword throws an Exception on unsuccessful login', () async {
      when(
        () => networkClient.post<Map<String, dynamic>>(
          Endpoints.login,
          data: const LoginRequestModel(
            email: email,
            password: password,
          ).toJson(),
        ),
      ).thenThrow(Exception());

      expect(
        () => loginApi.loginWithEmailAndPassword(
          loginRequestModel: const LoginRequestModel(
            email: email,
            password: password,
          ),
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}

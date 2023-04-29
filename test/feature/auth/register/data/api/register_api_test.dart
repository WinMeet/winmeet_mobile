import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:winmeet_mobile/app/constants/endpoints.dart';
import 'package:winmeet_mobile/core/clients/network/network_client.dart';
import 'package:winmeet_mobile/feature/auth/register/data/api/register_api.dart';
import 'package:winmeet_mobile/feature/auth/register/data/model/register_request_model.dart';

class MockNetworkClient extends Mock implements NetworkClient {}

void main() {
  late NetworkClient networkClient;
  late RegisterApi registerApi;

  const name = 'TestName';
  const surname = 'TestSurname';
  const email = 'test@test.com';
  const password = 'Test1234';

  setUp(() {
    networkClient = MockNetworkClient();
    registerApi = RegisterApi(networkClient: networkClient);
  });

  group('RegisterApi', () {
    test('registerWithEmailAndPassword calls networkClient.post with correct arguments', () async {
      const registerRequestModel = RegisterRequestModel(
        name: name,
        surname: surname,
        email: email,
        password: password,
      );

      when(
        () => networkClient.post<Map<String, dynamic>>(
          Endpoints.register,
          data: registerRequestModel.toJson(),
        ),
      ).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: {},
          requestOptions: RequestOptions(),
          statusCode: 200,
        ),
      );

      await registerApi.registerWithEmailAndPassword(registerRequestModel: registerRequestModel);

      verify(
        () => networkClient.post<Map<String, dynamic>>(
          Endpoints.register,
          data: registerRequestModel.toJson(),
        ),
      ).called(1);
    });

    test('registerWithEmailAndPassword throws an Exception on network error', () async {
      const registerRequestModel = RegisterRequestModel(
        name: name,
        surname: surname,
        email: email,
        password: password,
      );

      when(
        () => networkClient.post<Map<String, dynamic>>(
          Endpoints.register,
          data: registerRequestModel.toJson(),
        ),
      ).thenThrow(Exception());

      expect(
        () => registerApi.registerWithEmailAndPassword(registerRequestModel: registerRequestModel),
        throwsA(isA<Exception>()),
      );
    });
  });
}

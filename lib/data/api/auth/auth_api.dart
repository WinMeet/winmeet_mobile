import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/constants/endpoints.dart';
import 'package:winmeet_mobile/core/network/network_client.dart';
import 'package:winmeet_mobile/data/models/auth/login/login_request_model.dart';
import 'package:winmeet_mobile/data/models/auth/register/register_request_model.dart';

@injectable
class AuthApi {
  AuthApi({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  final NetworkClient _networkClient;

  Future<void> registerWithEmailAndPassword({
    required RegisterRequestModel registerRequestModel,
  }) async {
    await _networkClient.post<RegisterRequestModel>(
      Endpoints.register,
      data: registerRequestModel.toJson(),
    );
  }

  Future<void> loginWithEmailAndPassword({
    required LoginRequestModel loginRequestModel,
  }) async {
    await _networkClient.post<LoginRequestModel>(
      Endpoints.login,
      data: loginRequestModel.toJson(),
    );
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );
  }

  Future<void> signOut() async {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );
  }
}

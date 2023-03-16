import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/constants/endpoints.dart';
import 'package:winmeet_mobile/core/network/network_client.dart';
import 'package:winmeet_mobile/feature/auth/login/data/model/login_request_model.dart';

@injectable
class LoginApi {
  LoginApi({required NetworkClient networkClient}) : _networkClient = networkClient;

  final NetworkClient _networkClient;

  Future<void> loginWithEmailAndPassword({
    required LoginRequestModel loginRequestModel,
  }) async {
    await _networkClient.post<LoginRequestModel>(
      Endpoints.login,
      data: loginRequestModel.toJson(),
    );
  }
}

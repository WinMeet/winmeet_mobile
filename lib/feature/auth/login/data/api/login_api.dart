import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/constants/endpoints.dart';
import 'package:winmeet_mobile/app/data/model/token_model.dart';
import 'package:winmeet_mobile/core/network/network_client.dart';
import 'package:winmeet_mobile/feature/auth/login/data/model/login_request_model.dart';

@injectable
class LoginApi {
  LoginApi({required NetworkClient networkClient}) : _networkClient = networkClient;

  final NetworkClient _networkClient;

  Future<TokenModel> loginWithEmailAndPassword({required LoginRequestModel loginRequestModel}) async {
    try {
      final response = await _networkClient.post<Map<String, dynamic>>(
        Endpoints.login,
        data: loginRequestModel.toJson(),
      );
      final tokenModel = TokenModel.fromJson(response.data!);
      return tokenModel;
    } catch (e) {
      throw Exception(e);
    }
  }
}

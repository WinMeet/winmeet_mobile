import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/constants/endpoints.dart';
import 'package:winmeet_mobile/core/network/network_client.dart';
import 'package:winmeet_mobile/feature/auth/register/data/model/register_request_model.dart';

@injectable
class RegisterApi {
  RegisterApi({required NetworkClient networkClient}) : _networkClient = networkClient;

  final NetworkClient _networkClient;

  Future<void> registerWithEmailAndPassword({
    required RegisterRequestModel registerRequestModel,
  }) async {
    await _networkClient.post<RegisterRequestModel>(
      Endpoints.register,
      data: registerRequestModel.toJson(),
    );
  }
}

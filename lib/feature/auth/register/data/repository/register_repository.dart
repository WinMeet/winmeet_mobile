import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/exceptions/auth_exceptions.dart';
import 'package:winmeet_mobile/feature/auth/register/data/api/register_api.dart';
import 'package:winmeet_mobile/feature/auth/register/data/model/register_request_model.dart';

@injectable
class RegisterRepository {
  RegisterRepository({required RegisterApi registerApi}) : _registerApi = registerApi;

  final RegisterApi _registerApi;

  Future<void> registerWithEmailAndPassword({
    required RegisterRequestModel registerRequestModel,
  }) async {
    try {
      await _registerApi.registerWithEmailAndPassword(registerRequestModel: registerRequestModel);
    } catch (_) {
      throw const RegisterWithEmailAndPasswordFailure();
    }
  }
}

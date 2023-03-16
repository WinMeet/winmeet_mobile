import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/exceptions/auth_exceptions.dart';
import 'package:winmeet_mobile/feature/auth/login/data/api/login_api.dart';
import 'package:winmeet_mobile/feature/auth/login/data/model/login_request_model.dart';

@injectable
class LoginRepository {
  LoginRepository({required LoginApi loginApi}) : _loginApi = loginApi;

  final LoginApi _loginApi;

  Future<void> loginWithEmailAndPassword({
    required LoginRequestModel loginRequestModel,
  }) async {
    try {
      await _loginApi.loginWithEmailAndPassword(loginRequestModel: loginRequestModel);
    } catch (_) {
      throw const LoginWithEmailAndPasswordFailure();
    }
  }
}

import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/exceptions/auth_exceptions.dart';
import 'package:winmeet_mobile/data/api/auth/auth_api.dart';
import 'package:winmeet_mobile/data/models/auth/login/login_request_model.dart';
import 'package:winmeet_mobile/data/models/auth/register/register_request_model.dart';
import 'package:winmeet_mobile/data/repositories/auth/base_auth_repository.dart';

@Injectable(as: BaseAuthRepository)
class AuthRepository implements BaseAuthRepository {
  AuthRepository({required AuthApi authApi}) : _authApi = authApi;

  final AuthApi _authApi;

  @override
  Future<void> registerWithEmailAndPassword({
    required RegisterRequestModel registerRequestModel,
  }) async {
    try {
      await _authApi.registerWithEmailAndPassword(registerRequestModel: registerRequestModel);
    } catch (_) {
      throw const RegisterWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> loginWithEmailAndPassword({
    required LoginRequestModel loginRequestModel,
  }) async {
    try {
      await _authApi.loginWithEmailAndPassword(loginRequestModel: loginRequestModel);
    } catch (_) {
      throw const LoginWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _authApi.sendPasswordResetEmail(email: email);
    } catch (_) {
      throw const PasswordResetFailure();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _authApi.signOut();
    } catch (_) {
      throw const LogOutFailure();
    }
  }
}

import 'package:winmeet_mobile/app/exceptions/auth_exceptions.dart';
import 'package:winmeet_mobile/data/api/auth/auth_api.dart';
import 'package:winmeet_mobile/data/repositories/auth/base_auth_repository.dart';

class AuthRepository implements BaseAuthRepository {
  AuthRepository({required AuthApi authApi}) : _authApi = authApi;

  final AuthApi _authApi;

  @override
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authApi.registerWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {
      throw const RegisterWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authApi.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
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

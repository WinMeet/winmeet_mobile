import '../../../core/exceptions/auth_exceptions.dart';
import '../../api/auth/auth_api.dart';
import 'base_auth_repository.dart';

class AuthRepository implements BaseAuthRepository {
  AuthRepository({required this.authApi});

  final AuthApi authApi;

  @override
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await authApi.registerWithEmailAndPassword(
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
      await authApi.loginWithEmailAndPassword(
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
      await authApi.sendPasswordResetEmail(email: email);
    } catch (_) {
      throw const PasswordResetFailure();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await authApi.signOut();
    } catch (_) {
      throw const LogOutFailure();
    }
  }
}

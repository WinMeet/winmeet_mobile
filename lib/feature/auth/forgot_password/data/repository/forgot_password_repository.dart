import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/exceptions/auth_exceptions.dart';
import 'package:winmeet_mobile/feature/auth/forgot_password/data/api/forgot_password_api.dart';

@injectable
class ForgotPasswordRepository {
  ForgotPasswordRepository({required ForgotPasswordApi forgotPasswordApi}) : _forgotPasswordApi = forgotPasswordApi;

  final ForgotPasswordApi _forgotPasswordApi;

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _forgotPasswordApi.sendPasswordResetEmail(email: email);
    } catch (_) {
      throw const PasswordResetFailure();
    }
  }
}
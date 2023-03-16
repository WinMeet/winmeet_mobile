import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordApi {
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );
  }
}

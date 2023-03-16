import 'package:winmeet_mobile/data/models/auth/login/login_request_model.dart';
import 'package:winmeet_mobile/data/models/auth/register/register_request_model.dart';

abstract class BaseAuthRepository {
  Future<void> registerWithEmailAndPassword({
    required RegisterRequestModel registerRequestModel,
  });

  Future<void> loginWithEmailAndPassword({
    required LoginRequestModel loginRequestModel,
  });

  Future<void> sendPasswordResetEmail({
    required String email,
  });

  Future<void> signOut();
}

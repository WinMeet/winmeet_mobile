import 'dart:developer';
import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/core/model/failure/failure_model.dart';
import 'package:winmeet_mobile/feature/auth/register/data/api/register_api.dart';
import 'package:winmeet_mobile/feature/auth/register/data/model/register_request_model.dart';

@injectable
class RegisterRepository {
  RegisterRepository({required RegisterApi registerApi}) : _registerApi = registerApi;

  final RegisterApi _registerApi;

  Future<Either<FailureModel, void>> registerWithEmailAndPassword({
    required RegisterRequestModel registerRequestModel,
  }) async {
    try {
      final result = await _registerApi.registerWithEmailAndPassword(registerRequestModel: registerRequestModel);

      return right(result);
    } catch (e) {
      log(e.toString());
      return left(const FailureModel());
    }
  }
}

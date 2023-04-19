import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/constants/cache_contants.dart';
import 'package:winmeet_mobile/core/clients/cache/cache_client.dart';
import 'package:winmeet_mobile/core/model/failure/failure_model.dart';
import 'package:winmeet_mobile/feature/auth/login/data/api/login_api.dart';
import 'package:winmeet_mobile/feature/auth/login/data/model/login_request_model.dart';

@injectable
class LoginRepository {
  LoginRepository({required LoginApi loginApi, required CacheClient cacheClient})
      : _loginApi = loginApi,
        _cacheClient = cacheClient;

  final LoginApi _loginApi;
  final CacheClient _cacheClient;

  Future<Either<FailureModel, void>> loginWithEmailAndPassword({required LoginRequestModel loginRequestModel}) async {
    try {
      final tokenModel = await _loginApi.loginWithEmailAndPassword(loginRequestModel: loginRequestModel);
      final result = await _cacheClient.setString(CacheConstants.token, tokenModel.token);

      return right(result);
    } catch (e) {
      log(e.toString());
      return left(const FailureModel());
    }
  }
}

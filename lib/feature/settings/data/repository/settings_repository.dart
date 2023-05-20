import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/constants/cache_contants.dart';
import 'package:winmeet_mobile/app/utils/jwt/jwt_utils.dart';
import 'package:winmeet_mobile/core/clients/cache/cache_client.dart';

@injectable
class SettingsRepository {
  SettingsRepository({required CacheClient cacheClient}) : _cacheClient = cacheClient;

  final CacheClient _cacheClient;

  String getEmailFromUserToken() {
    final token = _cacheClient.getString(CacheConstants.token);
    if (token == null) {
      return '?';
    }
    return JwtUtils.getEmailFromToken(token: token);
  }

  String getNameSurnameFromUserToken() {
    final token = _cacheClient.getString(CacheConstants.token);
    if (token == null) {
      return '?';
    }
    return '${JwtUtils.getNameFromUserToken(token: token)} ${JwtUtils.getSurnameFromUserToken(token: token)}';
  }

  String getInitialsFromUserToken() {
    final token = _cacheClient.getString(CacheConstants.token);
    if (token == null) {
      return '?';
    }

    final name = JwtUtils.getNameFromUserToken(token: token);
    final surname = JwtUtils.getSurnameFromUserToken(token: token);
    return name[0] + surname[0];
  }
}

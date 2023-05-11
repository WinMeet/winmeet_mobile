import 'package:injectable/injectable.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:winmeet_mobile/app/constants/cache_contants.dart';
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
    final jwt = Jwt.parseJwt(token);
    final email = jwt['email'] as String;

    return email;
  }

  String getNameSurnameFromUserToken() {
    final token = _cacheClient.getString(CacheConstants.token);
    if (token == null) {
      return '?';
    }
    final jwt = Jwt.parseJwt(token);
    final name = jwt['given_name'] as String;
    final surname = jwt['family_name'] as String;
    return '$name $surname';
  }

  String getInitialsFromUserToken() {
    final token = _cacheClient.getString(CacheConstants.token);
    if (token == null) {
      return '?';
    }
    final jwt = Jwt.parseJwt(token);
    final name = jwt['given_name'] as String;
    final surname = jwt['family_name'] as String;
    return name[0] + surname[0];
  }
}

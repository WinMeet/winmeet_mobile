import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class CacheClient {
  CacheClient() {
    _init();
  }

  late SharedPreferences _cacheClient;

  Future<void> _init() async {
    _cacheClient = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _cacheClient.getString(key);
  }

  Future<void> setString(String key, String value) async {
    await _cacheClient.setString(key, value);
  }

  Future<void> deleteKey(String key) async {
    await _cacheClient.remove(key);
  }
}

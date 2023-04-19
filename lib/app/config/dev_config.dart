import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/core/config/app_config.dart';

@Injectable(as: AppConfig, env: [Environment.dev])
class DevConfig implements AppConfig {
  @override
  String get baseUrl => 'http://localhost:3001';
}

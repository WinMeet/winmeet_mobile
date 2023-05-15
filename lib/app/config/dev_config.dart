import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/core/config/app_config.dart';

@Injectable(as: AppConfig, env: [Environment.dev])
class DevConfig implements AppConfig {
  @override
  String get baseUrl => Platform.isIOS ? 'http://localhost:3002' : 'http://10.0.2.2:3002';
}

import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/core/config/app_config.dart';

@Injectable(as: AppConfig, env: [Environment.prod])
class ProdConfig implements AppConfig {
  @override
  // TODO: implement baseUrl
  String get baseUrl => 'https://1049-176-88-89-194.ngrok-free.app';
}

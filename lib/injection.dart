import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies(String environment) => getIt.init(environment: environment);

import 'package:get_it/get_it.dart';

import 'app/theme/app_theme.dart';
import 'app/theme/bloc/theme_bloc.dart';

import 'core/network/network_client.dart';
import 'data/api/auth/auth_api.dart';
import 'data/repositories/auth/auth_repository.dart';
import 'data/repositories/auth/base_auth_repository.dart';
import 'logic/auth/forgot_password/forgot_password_bloc.dart';
import 'logic/auth/login/login_bloc.dart';
import 'logic/auth/register/register_bloc.dart';

// Global service locator
final GetIt getIt = GetIt.instance;

void initServices() {
  //API
  getIt
    ..registerLazySingleton<AuthApi>(
      AuthApi.new,
    )

    // Core
    ..registerLazySingleton(
      AppTheme.new,
    )
    ..registerLazySingleton<NetworkClient>(
      NetworkClient.new,
    )

    //Repositories
    ..registerLazySingleton<BaseAuthRepository>(
      () => AuthRepository(
        authApi: getIt(),
      ),
    )

    //Blocs
    ..registerFactory(
      () => LoginBloc(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => RegisterBloc(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => ForgotPasswordBloc(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      ThemeBloc.new,
    );
}

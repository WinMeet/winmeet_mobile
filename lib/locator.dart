import 'package:get_it/get_it.dart';

import 'package:winmeet_mobile/app/theme/app_theme.dart';
import 'package:winmeet_mobile/app/theme/bloc/theme_bloc.dart';
import 'package:winmeet_mobile/core/network/network_client.dart';
import 'package:winmeet_mobile/data/api/auth/auth_api.dart';
import 'package:winmeet_mobile/data/repositories/auth/auth_repository.dart';
import 'package:winmeet_mobile/data/repositories/auth/base_auth_repository.dart';
import 'package:winmeet_mobile/logic/auth/forgot_password/forgot_password_cubit.dart';
import 'package:winmeet_mobile/logic/auth/login/login_cubit.dart';
import 'package:winmeet_mobile/logic/auth/register/cubit/register_cubit.dart';

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

    //Cubits
    ..registerFactory(
      () => LoginCubit(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => RegisterCubit(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => ForgotPasswordCubit(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      ThemeBloc.new,
    );
}

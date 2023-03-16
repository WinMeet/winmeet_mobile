import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/app/theme/app_theme.dart';
import 'package:winmeet_mobile/app/theme/cubit/theme_cubit.dart';
import 'package:winmeet_mobile/feature/auth/cubit/auth_cubit.dart';
import 'package:winmeet_mobile/feature/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:winmeet_mobile/injection.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<OnboardingCubit>(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => getIt<ThemeCubit>(),
        ),
      ],
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, onboardingState) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              final routes = <PageRouteInfo<dynamic>>[];

              if (onboardingState.isCompleted) {
                authState.map(
                  unauthenticated: (_) => routes.add(const UnauthenticatedRoutes()),
                  authenticated: (_) => routes.add(const AuthenticatedRoutes()),
                );
              } else {
                routes.add(const OnboardingRutes());
              }

              return BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, themeState) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,

                    // Theme
                    themeMode: themeState.theme,
                    theme: getIt<AppTheme>().lightTheme,
                    darkTheme: getIt<AppTheme>().darkTheme,

                    // Routing
                    routerDelegate: AutoRouterDelegate.declarative(_appRouter, routes: (_) => routes),
                    routeInformationParser: _appRouter.defaultRouteParser(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

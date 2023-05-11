import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winmeet_mobile/app/cubit/app_cubit.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/app/theme/cubit/theme_cubit.dart';
import 'package:winmeet_mobile/app/theme/dark/dark_theme.dart';
import 'package:winmeet_mobile/app/theme/light/light_theme.dart';
import 'package:winmeet_mobile/core/extensions/context_extensions.dart';
import 'package:winmeet_mobile/injection.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => getIt<ThemeCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AppCubit>()..checkAppState(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, appState) {
          final routes = <PageRouteInfo<dynamic>>[];

          appState.map(
            onboarding: (_) => routes.add(const OnboardingRutes()),
            unauthenticated: (_) => routes.add(const UnauthenticatedRoutes()),
            authenticated: (_) => routes.add(const AuthenticatedRoutes()),
          );

          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                //

                // Theme
                themeMode: themeState.theme,
                theme: getIt<LightTheme>().theme,
                darkTheme: getIt<DarkTheme>().theme,

                // Routing
                routerDelegate: AutoRouterDelegate.declarative(_appRouter, routes: (_) => routes),
                routeInformationParser: _appRouter.defaultRouteParser(),

                builder: (context, child) => MediaQuery(
                  // Disables font scaling and bold text
                  data: context.mediaQuery.copyWith(textScaleFactor: 1, boldText: false),
                  // Dismisses the keyboard globally
                  child: GestureDetector(
                    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                    child: child,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

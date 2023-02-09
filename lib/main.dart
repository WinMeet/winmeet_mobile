import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:winmeet_mobile/app/constants/strings.dart';
import 'package:winmeet_mobile/app/router/app_router.gr.dart';
import 'package:winmeet_mobile/app/theme/app_theme.dart';
import 'package:winmeet_mobile/app/theme/bloc/theme_bloc.dart';
import 'package:winmeet_mobile/core/utils/bloc/simple_bloc_observer.dart';
import 'package:winmeet_mobile/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  initServices();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(WinMeetMobile());
}

class WinMeetMobile extends StatelessWidget {
  WinMeetMobile({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => getIt<ThemeBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            title: Strings.appName,
            debugShowCheckedModeBanner: false,

            //theme
            themeMode: themeState.theme,
            theme: getIt<AppTheme>().lightTheme,
            darkTheme: getIt<AppTheme>().darkTheme,

            // routing
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}

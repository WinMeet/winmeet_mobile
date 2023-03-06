import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:winmeet_mobile/core/utils/bloc/simple_bloc_observer.dart';
import 'package:winmeet_mobile/injection.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder, String environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash();

  Bloc.observer = SimpleBlocObserver();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  configureDependencies(environment);

  runApp(await builder());
}

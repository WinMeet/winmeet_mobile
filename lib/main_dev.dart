import 'package:injectable/injectable.dart';
import 'package:winmeet_mobile/app/view/app.dart';
import 'package:winmeet_mobile/bootstrap.dart';

Future<void> main() async {
  await bootstrap(App.new, Environment.dev);
}

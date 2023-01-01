import 'package:auto_route/annotations.dart';

import '../../presentation/views/auth/forgot_password/forgot_password_view.dart';
import '../../presentation/views/auth/login/login_view.dart';
import '../../presentation/views/auth/register/register_view.dart';
import '../../presentation/views/home/home_view.dart';
import '../../presentation/views/navbar/navbar_view.dart';
import '../../presentation/views/scheduled_events/view/scheduled_events_view.dart';
import '../../presentation/views/settings/view/settings_view.dart';
import 'wrappers/home_wrapper.dart';
import 'wrappers/scheduled_events_wrapper.dart';
import 'wrappers/settings_wrapper.dart';

@MaterialAutoRouter(
  replaceInRouteName: "View,Route",
  preferRelativeImports: true,
  routes: <AutoRoute>[
    AutoRoute(
      page: LoginView,
      initial: true,
    ),
    AutoRoute(page: RegisterView),
    AutoRoute(page: ForgotPasswordView),
    AutoRoute(
      page: NavbarView,
      name: "NavbarRouter",
      children: [
        AutoRoute(
          page: HomeWrapper,
          name: "HomeRouter",
          initial: true,
          children: [
            AutoRoute(page: HomeView, initial: true),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          page: ScheduledEventsWrapper,
          name: "ScheduledEventsRouter",
          children: [
            AutoRoute(page: ScheduledEventsView, initial: true),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          page: SettingsWrapper,
          name: "SettingsRouter",
          children: [
            AutoRoute(page: SettingsView, initial: true),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
      ],
    ),
    RedirectRoute(path: '*', redirectTo: ''),
  ],
)
class $AppRouter {}

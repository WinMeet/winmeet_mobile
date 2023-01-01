import 'package:auto_route/annotations.dart';
import 'wrappers/home_wrapper.dart';
import 'wrappers/scheduled_events_wrapper.dart';
import 'wrappers/settings_wrapper.dart';
import '../../feature/settings/view/settings_view.dart';

import '../../feature/auth/forgot_password/view/forgot_password_view.dart';
import '../../feature/auth/login/view/login_view.dart';
import '../../feature/auth/register/view/register_view.dart';
import '../../feature/home/view/home_view.dart';
import '../../feature/navbar/view/navbar_view.dart';
import '../../feature/scheduled_events/view/scheduled_events_view.dart';

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

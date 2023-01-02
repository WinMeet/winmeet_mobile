import 'package:auto_route/annotations.dart';

import '../../presentation/views/add_participant/add_participant_view.dart';
import '../../presentation/views/auth/forgot_password/forgot_password_view.dart';
import '../../presentation/views/auth/login/login_view.dart';
import '../../presentation/views/auth/register/register_view.dart';
import '../../presentation/views/create_meeting/create_meeting_view.dart';
import '../../presentation/views/navbar/navbar_view.dart';
import '../../presentation/views/pending/pending.dart';
import '../../presentation/views/schedule/schedule_view.dart';
import '../../presentation/views/settings/settings_view.dart';
import 'wrappers/pending_wrapper.dart';
import 'wrappers/schedule_wrapper.dart';
import 'wrappers/settings_wrapper.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  preferRelativeImports: true,
  routes: <AutoRoute>[
    AutoRoute(page: LoginView),
    AutoRoute(page: RegisterView),
    AutoRoute(page: ForgotPasswordView),
    AutoRoute(page: CreateMeetingView),
    AutoRoute(page: AddParticipantView),
    AutoRoute(
      page: NavbarView,
      name: 'NavbarRouter',
      initial: true,
      children: [
        AutoRoute(
          page: ScheduleWrapper,
          name: 'ScheduleRouter',
          initial: true,
          children: [
            AutoRoute(page: ScheduleView, initial: true),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          page: PendingWrapper,
          name: 'PendingRouter',
          children: [
            AutoRoute(page: PendingView, initial: true),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          page: SettingsWrapper,
          name: 'SettingsRouter',
          children: [
            AutoRoute(page: SettingsView, initial: true),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
      ],
    ),
    RedirectRoute(path: '', redirectTo: ''),
  ],
)
class $AppRouter {}

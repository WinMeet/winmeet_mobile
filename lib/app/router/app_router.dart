import 'package:auto_route/annotations.dart';
import 'package:winmeet_mobile/app/router/wrappers/pending_wrapper.dart';
import 'package:winmeet_mobile/app/router/wrappers/schedule_wrapper.dart';
import 'package:winmeet_mobile/app/router/wrappers/settings_wrapper.dart';
import 'package:winmeet_mobile/presentation/views/add_participant/add_participant_view.dart';
import 'package:winmeet_mobile/presentation/views/auth/forgot_password/forgot_password_view.dart';
import 'package:winmeet_mobile/presentation/views/auth/login/login_view.dart';
import 'package:winmeet_mobile/presentation/views/auth/register/register_view.dart';
import 'package:winmeet_mobile/presentation/views/create_meeting/create_meeting_view.dart';
import 'package:winmeet_mobile/presentation/views/navbar/navbar_view.dart';
import 'package:winmeet_mobile/presentation/views/pending/pending.dart';
import 'package:winmeet_mobile/presentation/views/schedule/schedule_view.dart';
import 'package:winmeet_mobile/presentation/views/settings/settings_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  preferRelativeImports: true,
  routes: <AutoRoute>[
    AutoRoute(
      page: LoginView,
      initial: true,
    ),
    AutoRoute(page: RegisterView),
    AutoRoute(page: ForgotPasswordView),
    AutoRoute(page: CreateMeetingView),
    AutoRoute(page: AddParticipantView),
    AutoRoute(
      page: NavbarView,
      name: 'NavbarRouter',
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

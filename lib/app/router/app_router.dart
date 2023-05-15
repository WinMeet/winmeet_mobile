import 'package:auto_route/annotations.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:winmeet_mobile/feature/auth/forgot_password/presentation/view/forgot_password_view.dart';
import 'package:winmeet_mobile/feature/auth/login/presentation/view/login_view.dart';
import 'package:winmeet_mobile/feature/auth/register/presentation/view/register_view.dart';
import 'package:winmeet_mobile/feature/create_meeting/presentation/view/add_participants_view.dart';
import 'package:winmeet_mobile/feature/create_meeting/presentation/view/create_meeting_view.dart';
import 'package:winmeet_mobile/feature/navbar/navbar_view.dart';
import 'package:winmeet_mobile/feature/onboarding/presentation/view/onboarding_view.dart';
import 'package:winmeet_mobile/feature/pending/presentation/view/pending_view.dart';
import 'package:winmeet_mobile/feature/schedule/presentation/view/schedule_view.dart';
import 'package:winmeet_mobile/feature/settings/presentation/view/settings_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: [
    onboarding,
    unauthenticated,
    authenticated,
  ],
)
class $AppRouter {}

const onboarding = AutoRoute(
  name: 'OnboardingRutes',
  page: EmptyRouterPage,
  children: [
    AutoRoute(initial: true, page: OnboardingView),
    RedirectRoute(path: '*', redirectTo: ''),
  ],
);

const unauthenticated = AutoRoute(
  name: 'UnauthenticatedRoutes',
  page: EmptyRouterPage,
  children: [
    AutoRoute(initial: true, page: LoginView),
    AutoRoute(page: RegisterView),
    AutoRoute(page: ForgotPasswordView),
    RedirectRoute(path: '*', redirectTo: ''),
  ],
);

const authenticated = AutoRoute(
  name: 'AuthenticatedRoutes',
  page: EmptyRouterPage,
  children: [
    AutoRoute(
      page: NavbarView,
      initial: true,
      children: [
        AutoRoute(
          page: EmptyRouterPage,
          name: 'ScheduleRouter',
          initial: true,
          children: [
            AutoRoute(page: ScheduleView, initial: true),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'PendingRouter',
          children: [
            AutoRoute(page: PendingView, initial: true),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'SettingsRouter',
          children: [
            AutoRoute(page: SettingsView, initial: true),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
      ],
    ),
    AutoRoute(page: CreateMeetingView),
    AutoRoute(page: AddParticipantsView),
    RedirectRoute(path: '*', redirectTo: ''),
  ],
);

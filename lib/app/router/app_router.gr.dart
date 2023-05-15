// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:auto_route/empty_router_widgets.dart' as _i1;
import 'package:flutter/material.dart' as _i13;

import '../../feature/auth/forgot_password/presentation/view/forgot_password_view.dart'
    as _i5;
import '../../feature/auth/login/presentation/view/login_view.dart' as _i3;
import '../../feature/auth/register/presentation/view/register_view.dart'
    as _i4;
import '../../feature/create_meeting/presentation/cubit/create_meeting_cubit.dart'
    as _i15;
import '../../feature/create_meeting/presentation/view/add_participants_view.dart'
    as _i8;
import '../../feature/create_meeting/presentation/view/create_meeting_view.dart'
    as _i7;
import '../../feature/navbar/navbar_view.dart' as _i6;
import '../../feature/onboarding/presentation/view/onboarding_view.dart' as _i2;
import '../../feature/pending/presentation/view/pending_view.dart' as _i10;
import '../../feature/schedule/presentation/cubit/schedule_cubit.dart' as _i14;
import '../../feature/schedule/presentation/view/schedule_view.dart' as _i9;
import '../../feature/settings/presentation/view/settings_view.dart' as _i11;

class AppRouter extends _i12.RootStackRouter {
  AppRouter([_i13.GlobalKey<_i13.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    OnboardingRutes.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    UnauthenticatedRoutes.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    AuthenticatedRoutes.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.OnboardingView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.LoginView(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterView(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.ForgotPasswordView(),
      );
    },
    NavbarRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.NavbarView(),
      );
    },
    CreateMeetingRoute.name: (routeData) {
      final args = routeData.argsAs<CreateMeetingRouteArgs>();
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.CreateMeetingView(
          cubit: args.cubit,
          key: args.key,
        ),
      );
    },
    AddParticipantsRoute.name: (routeData) {
      final args = routeData.argsAs<AddParticipantsRouteArgs>();
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.AddParticipantsView(
          cubit: args.cubit,
          key: args.key,
        ),
      );
    },
    ScheduleRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    PendingRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    SettingsRouter.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyRouterPage(),
      );
    },
    ScheduleRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.ScheduleView(),
      );
    },
    PendingRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.PendingView(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.SettingsView(),
      );
    },
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(
          OnboardingRutes.name,
          path: '/empty-router-page',
          children: [
            _i12.RouteConfig(
              OnboardingRoute.name,
              path: '',
              parent: OnboardingRutes.name,
            ),
            _i12.RouteConfig(
              '*#redirect',
              path: '*',
              parent: OnboardingRutes.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i12.RouteConfig(
          UnauthenticatedRoutes.name,
          path: '/empty-router-page',
          children: [
            _i12.RouteConfig(
              LoginRoute.name,
              path: '',
              parent: UnauthenticatedRoutes.name,
            ),
            _i12.RouteConfig(
              RegisterRoute.name,
              path: 'register-view',
              parent: UnauthenticatedRoutes.name,
            ),
            _i12.RouteConfig(
              ForgotPasswordRoute.name,
              path: 'forgot-password-view',
              parent: UnauthenticatedRoutes.name,
            ),
            _i12.RouteConfig(
              '*#redirect',
              path: '*',
              parent: UnauthenticatedRoutes.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i12.RouteConfig(
          AuthenticatedRoutes.name,
          path: '/empty-router-page',
          children: [
            _i12.RouteConfig(
              NavbarRoute.name,
              path: '',
              parent: AuthenticatedRoutes.name,
              children: [
                _i12.RouteConfig(
                  ScheduleRouter.name,
                  path: '',
                  parent: NavbarRoute.name,
                  children: [
                    _i12.RouteConfig(
                      ScheduleRoute.name,
                      path: '',
                      parent: ScheduleRouter.name,
                    ),
                    _i12.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: ScheduleRouter.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i12.RouteConfig(
                  PendingRouter.name,
                  path: 'empty-router-page',
                  parent: NavbarRoute.name,
                  children: [
                    _i12.RouteConfig(
                      PendingRoute.name,
                      path: '',
                      parent: PendingRouter.name,
                    ),
                    _i12.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: PendingRouter.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i12.RouteConfig(
                  SettingsRouter.name,
                  path: 'empty-router-page',
                  parent: NavbarRoute.name,
                  children: [
                    _i12.RouteConfig(
                      SettingsRoute.name,
                      path: '',
                      parent: SettingsRouter.name,
                    ),
                    _i12.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: SettingsRouter.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
              ],
            ),
            _i12.RouteConfig(
              CreateMeetingRoute.name,
              path: 'create-meeting-view',
              parent: AuthenticatedRoutes.name,
            ),
            _i12.RouteConfig(
              AddParticipantsRoute.name,
              path: 'add-participants-view',
              parent: AuthenticatedRoutes.name,
            ),
            _i12.RouteConfig(
              '*#redirect',
              path: '*',
              parent: AuthenticatedRoutes.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class OnboardingRutes extends _i12.PageRouteInfo<void> {
  const OnboardingRutes({List<_i12.PageRouteInfo>? children})
      : super(
          OnboardingRutes.name,
          path: '/empty-router-page',
          initialChildren: children,
        );

  static const String name = 'OnboardingRutes';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class UnauthenticatedRoutes extends _i12.PageRouteInfo<void> {
  const UnauthenticatedRoutes({List<_i12.PageRouteInfo>? children})
      : super(
          UnauthenticatedRoutes.name,
          path: '/empty-router-page',
          initialChildren: children,
        );

  static const String name = 'UnauthenticatedRoutes';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class AuthenticatedRoutes extends _i12.PageRouteInfo<void> {
  const AuthenticatedRoutes({List<_i12.PageRouteInfo>? children})
      : super(
          AuthenticatedRoutes.name,
          path: '/empty-router-page',
          initialChildren: children,
        );

  static const String name = 'AuthenticatedRoutes';
}

/// generated route for
/// [_i2.OnboardingView]
class OnboardingRoute extends _i12.PageRouteInfo<void> {
  const OnboardingRoute()
      : super(
          OnboardingRoute.name,
          path: '',
        );

  static const String name = 'OnboardingRoute';
}

/// generated route for
/// [_i3.LoginView]
class LoginRoute extends _i12.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.RegisterView]
class RegisterRoute extends _i12.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: 'register-view',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i5.ForgotPasswordView]
class ForgotPasswordRoute extends _i12.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(
          ForgotPasswordRoute.name,
          path: 'forgot-password-view',
        );

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i6.NavbarView]
class NavbarRoute extends _i12.PageRouteInfo<void> {
  const NavbarRoute({List<_i12.PageRouteInfo>? children})
      : super(
          NavbarRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'NavbarRoute';
}

/// generated route for
/// [_i7.CreateMeetingView]
class CreateMeetingRoute extends _i12.PageRouteInfo<CreateMeetingRouteArgs> {
  CreateMeetingRoute({
    required _i14.ScheduleCubit cubit,
    _i13.Key? key,
  }) : super(
          CreateMeetingRoute.name,
          path: 'create-meeting-view',
          args: CreateMeetingRouteArgs(
            cubit: cubit,
            key: key,
          ),
        );

  static const String name = 'CreateMeetingRoute';
}

class CreateMeetingRouteArgs {
  const CreateMeetingRouteArgs({
    required this.cubit,
    this.key,
  });

  final _i14.ScheduleCubit cubit;

  final _i13.Key? key;

  @override
  String toString() {
    return 'CreateMeetingRouteArgs{cubit: $cubit, key: $key}';
  }
}

/// generated route for
/// [_i8.AddParticipantsView]
class AddParticipantsRoute
    extends _i12.PageRouteInfo<AddParticipantsRouteArgs> {
  AddParticipantsRoute({
    required _i15.CreateMeetingCubit cubit,
    _i13.Key? key,
  }) : super(
          AddParticipantsRoute.name,
          path: 'add-participants-view',
          args: AddParticipantsRouteArgs(
            cubit: cubit,
            key: key,
          ),
        );

  static const String name = 'AddParticipantsRoute';
}

class AddParticipantsRouteArgs {
  const AddParticipantsRouteArgs({
    required this.cubit,
    this.key,
  });

  final _i15.CreateMeetingCubit cubit;

  final _i13.Key? key;

  @override
  String toString() {
    return 'AddParticipantsRouteArgs{cubit: $cubit, key: $key}';
  }
}

/// generated route for
/// [_i1.EmptyRouterPage]
class ScheduleRouter extends _i12.PageRouteInfo<void> {
  const ScheduleRouter({List<_i12.PageRouteInfo>? children})
      : super(
          ScheduleRouter.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'ScheduleRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class PendingRouter extends _i12.PageRouteInfo<void> {
  const PendingRouter({List<_i12.PageRouteInfo>? children})
      : super(
          PendingRouter.name,
          path: 'empty-router-page',
          initialChildren: children,
        );

  static const String name = 'PendingRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class SettingsRouter extends _i12.PageRouteInfo<void> {
  const SettingsRouter({List<_i12.PageRouteInfo>? children})
      : super(
          SettingsRouter.name,
          path: 'empty-router-page',
          initialChildren: children,
        );

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i9.ScheduleView]
class ScheduleRoute extends _i12.PageRouteInfo<void> {
  const ScheduleRoute()
      : super(
          ScheduleRoute.name,
          path: '',
        );

  static const String name = 'ScheduleRoute';
}

/// generated route for
/// [_i10.PendingView]
class PendingRoute extends _i12.PageRouteInfo<void> {
  const PendingRoute()
      : super(
          PendingRoute.name,
          path: '',
        );

  static const String name = 'PendingRoute';
}

/// generated route for
/// [_i11.SettingsView]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: '',
        );

  static const String name = 'SettingsRoute';
}

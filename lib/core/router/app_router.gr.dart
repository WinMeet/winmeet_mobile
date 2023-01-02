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
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;

import '../../presentation/views/add_participant/add_participant_view.dart'
    as _i5;
import '../../presentation/views/auth/forgot_password/forgot_password_view.dart'
    as _i3;
import '../../presentation/views/auth/login/login_view.dart' as _i1;
import '../../presentation/views/auth/register/register_view.dart' as _i2;
import '../../presentation/views/create_meeting/create_meeting_view.dart'
    as _i4;
import '../../presentation/views/navbar/navbar_view.dart' as _i6;
import '../../presentation/views/pending/pending.dart' as _i11;
import '../../presentation/views/schedule/schedule_view.dart' as _i10;
import '../../presentation/views/settings/settings_view.dart' as _i12;
import 'wrappers/pending_wrapper.dart' as _i8;
import 'wrappers/schedule_wrapper.dart' as _i7;
import 'wrappers/settings_wrapper.dart' as _i9;

class AppRouter extends _i13.RootStackRouter {
  AppRouter([_i14.GlobalKey<_i14.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginView(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterView(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.ForgotPasswordView(),
      );
    },
    CreateMeetingRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.CreateMeetingView(),
      );
    },
    AddParticipantRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.AddParticipantView(),
      );
    },
    NavbarRouter.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.NavbarView(),
      );
    },
    ScheduleRouter.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.WrappedRoute(child: _i7.ScheduleWrapper()),
      );
    },
    PendingRouter.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.WrappedRoute(child: _i8.PendingWrapper()),
      );
    },
    SettingsRouter.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.WrappedRoute(child: _i9.SettingsWrapper()),
      );
    },
    ScheduleRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.ScheduleView(),
      );
    },
    PendingRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.PendingView(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.SettingsView(),
      );
    },
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(
          LoginRoute.name,
          path: '/',
        ),
        _i13.RouteConfig(
          RegisterRoute.name,
          path: '/register-view',
        ),
        _i13.RouteConfig(
          ForgotPasswordRoute.name,
          path: '/forgot-password-view',
        ),
        _i13.RouteConfig(
          CreateMeetingRoute.name,
          path: '/create-meeting-view',
        ),
        _i13.RouteConfig(
          AddParticipantRoute.name,
          path: '/add-participant-view',
        ),
        _i13.RouteConfig(
          NavbarRouter.name,
          path: '/navbar-view',
          children: [
            _i13.RouteConfig(
              ScheduleRouter.name,
              path: '',
              parent: NavbarRouter.name,
              children: [
                _i13.RouteConfig(
                  ScheduleRoute.name,
                  path: '',
                  parent: ScheduleRouter.name,
                ),
                _i13.RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: ScheduleRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            _i13.RouteConfig(
              PendingRouter.name,
              path: 'pending-wrapper',
              parent: NavbarRouter.name,
              children: [
                _i13.RouteConfig(
                  PendingRoute.name,
                  path: '',
                  parent: PendingRouter.name,
                ),
                _i13.RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: PendingRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            _i13.RouteConfig(
              SettingsRouter.name,
              path: 'settings-wrapper',
              parent: NavbarRouter.name,
              children: [
                _i13.RouteConfig(
                  SettingsRoute.name,
                  path: '',
                  parent: SettingsRouter.name,
                ),
                _i13.RouteConfig(
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
        _i13.RouteConfig(
          '#redirect',
          path: '',
          redirectTo: '',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.LoginView]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.RegisterView]
class RegisterRoute extends _i13.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register-view',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i3.ForgotPasswordView]
class ForgotPasswordRoute extends _i13.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(
          ForgotPasswordRoute.name,
          path: '/forgot-password-view',
        );

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i4.CreateMeetingView]
class CreateMeetingRoute extends _i13.PageRouteInfo<void> {
  const CreateMeetingRoute()
      : super(
          CreateMeetingRoute.name,
          path: '/create-meeting-view',
        );

  static const String name = 'CreateMeetingRoute';
}

/// generated route for
/// [_i5.AddParticipantView]
class AddParticipantRoute extends _i13.PageRouteInfo<void> {
  const AddParticipantRoute()
      : super(
          AddParticipantRoute.name,
          path: '/add-participant-view',
        );

  static const String name = 'AddParticipantRoute';
}

/// generated route for
/// [_i6.NavbarView]
class NavbarRouter extends _i13.PageRouteInfo<void> {
  const NavbarRouter({List<_i13.PageRouteInfo>? children})
      : super(
          NavbarRouter.name,
          path: '/navbar-view',
          initialChildren: children,
        );

  static const String name = 'NavbarRouter';
}

/// generated route for
/// [_i7.ScheduleWrapper]
class ScheduleRouter extends _i13.PageRouteInfo<void> {
  const ScheduleRouter({List<_i13.PageRouteInfo>? children})
      : super(
          ScheduleRouter.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'ScheduleRouter';
}

/// generated route for
/// [_i8.PendingWrapper]
class PendingRouter extends _i13.PageRouteInfo<void> {
  const PendingRouter({List<_i13.PageRouteInfo>? children})
      : super(
          PendingRouter.name,
          path: 'pending-wrapper',
          initialChildren: children,
        );

  static const String name = 'PendingRouter';
}

/// generated route for
/// [_i9.SettingsWrapper]
class SettingsRouter extends _i13.PageRouteInfo<void> {
  const SettingsRouter({List<_i13.PageRouteInfo>? children})
      : super(
          SettingsRouter.name,
          path: 'settings-wrapper',
          initialChildren: children,
        );

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i10.ScheduleView]
class ScheduleRoute extends _i13.PageRouteInfo<void> {
  const ScheduleRoute()
      : super(
          ScheduleRoute.name,
          path: '',
        );

  static const String name = 'ScheduleRoute';
}

/// generated route for
/// [_i11.PendingView]
class PendingRoute extends _i13.PageRouteInfo<void> {
  const PendingRoute()
      : super(
          PendingRoute.name,
          path: '',
        );

  static const String name = 'PendingRoute';
}

/// generated route for
/// [_i12.SettingsView]
class SettingsRoute extends _i13.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: '',
        );

  static const String name = 'SettingsRoute';
}

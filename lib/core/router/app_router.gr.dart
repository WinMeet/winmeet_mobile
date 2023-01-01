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
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;

import '../../presentation/views/auth/forgot_password/forgot_password_view.dart'
    as _i3;
import '../../presentation/views/auth/login/login_view.dart' as _i1;
import '../../presentation/views/auth/register/register_view.dart' as _i2;
import '../../presentation/views/navbar/navbar_view.dart' as _i4;
import '../../presentation/views/pending/pending.dart' as _i9;
import '../../presentation/views/schedule/schedule_view.dart' as _i8;
import '../../presentation/views/settings/settings_view.dart' as _i10;
import 'wrappers/pending_wrapper.dart' as _i6;
import 'wrappers/schedule_wrapper.dart' as _i5;
import 'wrappers/settings_wrapper.dart' as _i7;

class AppRouter extends _i11.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginView(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterView(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.ForgotPasswordView(),
      );
    },
    NavbarRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.NavbarView(),
      );
    },
    ScheduleRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.WrappedRoute(child: _i5.ScheduleWrapper()),
      );
    },
    PendingRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.WrappedRoute(child: _i6.PendingWrapper()),
      );
    },
    SettingsRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.WrappedRoute(child: _i7.SettingsWrapper()),
      );
    },
    ScheduleRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.ScheduleView(),
      );
    },
    PendingRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.PendingView(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.SettingsView(),
      );
    },
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(
          LoginRoute.name,
          path: '/login-view',
        ),
        _i11.RouteConfig(
          RegisterRoute.name,
          path: '/register-view',
        ),
        _i11.RouteConfig(
          ForgotPasswordRoute.name,
          path: '/forgot-password-view',
        ),
        _i11.RouteConfig(
          NavbarRouter.name,
          path: '/',
          children: [
            _i11.RouteConfig(
              ScheduleRouter.name,
              path: '',
              parent: NavbarRouter.name,
              children: [
                _i11.RouteConfig(
                  ScheduleRoute.name,
                  path: '',
                  parent: ScheduleRouter.name,
                ),
                _i11.RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: ScheduleRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            _i11.RouteConfig(
              PendingRouter.name,
              path: 'pending-wrapper',
              parent: NavbarRouter.name,
              children: [
                _i11.RouteConfig(
                  PendingRoute.name,
                  path: '',
                  parent: PendingRouter.name,
                ),
                _i11.RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: PendingRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            _i11.RouteConfig(
              SettingsRouter.name,
              path: 'settings-wrapper',
              parent: NavbarRouter.name,
              children: [
                _i11.RouteConfig(
                  SettingsRoute.name,
                  path: '',
                  parent: SettingsRouter.name,
                ),
                _i11.RouteConfig(
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
        _i11.RouteConfig(
          '#redirect',
          path: '',
          redirectTo: '',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.LoginView]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-view',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.RegisterView]
class RegisterRoute extends _i11.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register-view',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i3.ForgotPasswordView]
class ForgotPasswordRoute extends _i11.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(
          ForgotPasswordRoute.name,
          path: '/forgot-password-view',
        );

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i4.NavbarView]
class NavbarRouter extends _i11.PageRouteInfo<void> {
  const NavbarRouter({List<_i11.PageRouteInfo>? children})
      : super(
          NavbarRouter.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'NavbarRouter';
}

/// generated route for
/// [_i5.ScheduleWrapper]
class ScheduleRouter extends _i11.PageRouteInfo<void> {
  const ScheduleRouter({List<_i11.PageRouteInfo>? children})
      : super(
          ScheduleRouter.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'ScheduleRouter';
}

/// generated route for
/// [_i6.PendingWrapper]
class PendingRouter extends _i11.PageRouteInfo<void> {
  const PendingRouter({List<_i11.PageRouteInfo>? children})
      : super(
          PendingRouter.name,
          path: 'pending-wrapper',
          initialChildren: children,
        );

  static const String name = 'PendingRouter';
}

/// generated route for
/// [_i7.SettingsWrapper]
class SettingsRouter extends _i11.PageRouteInfo<void> {
  const SettingsRouter({List<_i11.PageRouteInfo>? children})
      : super(
          SettingsRouter.name,
          path: 'settings-wrapper',
          initialChildren: children,
        );

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i8.ScheduleView]
class ScheduleRoute extends _i11.PageRouteInfo<void> {
  const ScheduleRoute()
      : super(
          ScheduleRoute.name,
          path: '',
        );

  static const String name = 'ScheduleRoute';
}

/// generated route for
/// [_i9.PendingView]
class PendingRoute extends _i11.PageRouteInfo<void> {
  const PendingRoute()
      : super(
          PendingRoute.name,
          path: '',
        );

  static const String name = 'PendingRoute';
}

/// generated route for
/// [_i10.SettingsView]
class SettingsRoute extends _i11.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: '',
        );

  static const String name = 'SettingsRoute';
}

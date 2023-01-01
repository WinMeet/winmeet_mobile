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

import '../../feature/auth/forgot_password/view/forgot_password_view.dart'
    as _i3;
import '../../feature/auth/login/view/login_view.dart' as _i1;
import '../../feature/auth/register/view/register_view.dart' as _i2;
import '../../feature/home/view/home_view.dart' as _i8;
import '../../feature/navbar/view/navbar_view.dart' as _i4;
import '../../feature/scheduled_events/view/scheduled_events_view.dart' as _i9;
import '../../feature/settings/view/settings_view.dart' as _i10;
import 'wrappers/home_wrapper.dart' as _i5;
import 'wrappers/scheduled_events_wrapper.dart' as _i6;
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
    HomeRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.WrappedRoute(child: _i5.HomeWrapper()),
      );
    },
    ScheduledEventsRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.WrappedRoute(child: _i6.ScheduledEventsWrapper()),
      );
    },
    SettingsRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.WrappedRoute(child: _i7.SettingsWrapper()),
      );
    },
    HomeRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.HomeView(),
      );
    },
    ScheduledEventsRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.ScheduledEventsView(),
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
          path: '/',
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
          path: '/navbar-view',
          children: [
            _i11.RouteConfig(
              HomeRouter.name,
              path: '',
              parent: NavbarRouter.name,
              children: [
                _i11.RouteConfig(
                  HomeRoute.name,
                  path: '',
                  parent: HomeRouter.name,
                ),
                _i11.RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: HomeRouter.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            _i11.RouteConfig(
              ScheduledEventsRouter.name,
              path: 'scheduled-events-wrapper',
              parent: NavbarRouter.name,
              children: [
                _i11.RouteConfig(
                  ScheduledEventsRoute.name,
                  path: '',
                  parent: ScheduledEventsRouter.name,
                ),
                _i11.RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: ScheduledEventsRouter.name,
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
          '*#redirect',
          path: '*',
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
          path: '/',
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
          path: '/navbar-view',
          initialChildren: children,
        );

  static const String name = 'NavbarRouter';
}

/// generated route for
/// [_i5.HomeWrapper]
class HomeRouter extends _i11.PageRouteInfo<void> {
  const HomeRouter({List<_i11.PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i6.ScheduledEventsWrapper]
class ScheduledEventsRouter extends _i11.PageRouteInfo<void> {
  const ScheduledEventsRouter({List<_i11.PageRouteInfo>? children})
      : super(
          ScheduledEventsRouter.name,
          path: 'scheduled-events-wrapper',
          initialChildren: children,
        );

  static const String name = 'ScheduledEventsRouter';
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
/// [_i8.HomeView]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i9.ScheduledEventsView]
class ScheduledEventsRoute extends _i11.PageRouteInfo<void> {
  const ScheduledEventsRoute()
      : super(
          ScheduledEventsRoute.name,
          path: '',
        );

  static const String name = 'ScheduledEventsRoute';
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

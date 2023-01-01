import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class HomeWrapper implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return const AutoRouter();
  }
}

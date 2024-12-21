import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouterMock {
  static GoRouter getRouter(
      Widget initialWidget, Widget nextWidget, String nextWidgetRoutePath) {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => initialWidget,
        ),
        GoRoute(
          path: nextWidgetRoutePath,
          builder: (context, state) => nextWidget,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/feature/home/screens/home_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routers.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
    ],
  );
}

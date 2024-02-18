import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plastic_bay/features/authentication/screen/register.dart';
import 'package:plastic_bay/features/home/screens/home_page.dart';
import 'package:plastic_bay/features/home/screens/welcome_page.dart';
import 'package:plastic_bay/routes/route_path.dart';

import '../features/authentication/screen/login.dart';
import '../features/home/screens/auth_checker.dart';

final GoRouter routeConfig = GoRouter(
  routes: <RouteBase>[
      GoRoute(
      path: RoutePath.authState,
      name: RoutePath.authState,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthChecker();
      },
    ),
    GoRoute(
      path: RoutePath.home,
      name: RoutePath.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      name: RoutePath.signUp,
      path: RoutePath.signUp,
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpScreen();
      },
    ),
     GoRoute(
      name: RoutePath.signIn,
      path: RoutePath.signIn,
      builder: (BuildContext context, GoRouterState state) {
        return const SignInScreen();
      },
    ),
  ],
);

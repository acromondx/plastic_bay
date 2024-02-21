import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waste_company/features/authentication/screen/sign_up.dart';
import 'package:waste_company/features/waste_management/screen/check_out.dart';
import 'package:waste_company/model/plastic.dart';

import '../features/authentication/screen/auth_checker.dart';
import '../features/authentication/screen/sign_in.dart';
import '../features/home/home_page.dart';
import 'route_path.dart';

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
    GoRoute(
      name: RoutePath.acceptPost,
      path: RoutePath.acceptPost,
      builder: (BuildContext context, GoRouterState state) {
        final plastic = state.extra as Plastic;
        return PostCheckOut(
          plastic: plastic,
        );
      },
    ),
    // GoRoute(
    //   path: RoutePath.createPost,
    //   name: RoutePath.createPost,
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       key: state.pageKey,
    //       child: const CreatePost(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(

    //           opacity:
    //               CurveTween(curve: Curves.ease).animate(animation),
    //           child: child,
    //         );
    //       },
    //     );
    //   },
    // ),
  ],
);

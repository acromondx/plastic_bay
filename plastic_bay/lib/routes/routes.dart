import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plastic_bay/features/authentication/screen/register.dart';
import 'package:plastic_bay/features/home/screens/home_page.dart';
import 'package:plastic_bay/features/home/screens/welcome_page.dart';
import 'package:plastic_bay/model/reward.dart';
import 'package:plastic_bay/routes/route_path.dart';

import '../features/authentication/screen/login.dart';
import '../features/home/screens/auth_checker.dart';
import '../features/plastic management/screen/create_post.dart';
import '../features/rewards/screen/reward_details.dart';

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
      name: RoutePath.rewardDetails,
      path: RoutePath.rewardDetails,
      builder: (BuildContext context, GoRouterState state) {
        final reward = state.extra as Reward;
        return RewardDetails(
          reward: reward,
        );
      },
    ),
    GoRoute(
      path: RoutePath.createPost,
      name: RoutePath.createPost,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const CreatePost(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(

              opacity:
                  CurveTween(curve: Curves.ease).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);

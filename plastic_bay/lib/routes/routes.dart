import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plastic_bay/features/authentication/screen/sign_up.dart';
import 'package:plastic_bay/features/gemini/screen/chat.dart';
import 'package:plastic_bay/features/home/screens/home_page.dart';
import 'package:plastic_bay/features/rewards/screen/order_detail.dart';
import 'package:plastic_bay/model/reward.dart';
import 'package:plastic_bay/routes/route_path.dart';

import '../features/authentication/screen/login.dart';
import '../features/authentication/screen/auth_checker.dart';
import '../features/plastic management/screen/create_post.dart';
import '../features/rewards/screen/orders.dart';
import '../features/rewards/screen/reward_details.dart';
import '../features/rewards/screen/rewards_checkout.dart';
import '../features/rewards/widget/order_sucess_card.dart';

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
      name: RoutePath.successfulOrder,
      path: RoutePath.successfulOrder,
      builder: (BuildContext context, GoRouterState state) {
        return const SuccessfulOrder();
      },
    ),
    GoRoute(
      name: RoutePath.orderScreen,
      path: RoutePath.orderScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const OrdersScreen();
      },
    ),
    GoRoute(
      name: RoutePath.orderDetailsScreen,
      path: RoutePath.orderDetailsScreen,
      builder: (BuildContext context, GoRouterState state) {
        final rewards = state.extra as List<Reward>;
        return OrderDetailsScreen(
          rewards: rewards,
        );
      },
    ),
    GoRoute(
      name: RoutePath.geminiChat,
      path: RoutePath.geminiChat,
      builder: (BuildContext context, GoRouterState state) {
        return const GeminiChat();
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
              opacity: CurveTween(curve: Curves.easeIn).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: RoutePath.rewardCheckOut,
      name: RoutePath.rewardCheckOut,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const RewardsCheckOut(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeIn).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);

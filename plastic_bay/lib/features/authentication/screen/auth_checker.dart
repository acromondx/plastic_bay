import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_bay/api/providers.dart';
import 'package:plastic_bay/features/authentication/screen/sign_up.dart';
import 'package:plastic_bay/features/home/screens/home_page.dart';
import 'package:plastic_bay/utils/loading_alert.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(authStateProvider).when(
          data: (user) {
            if (user == null) {
              return const SignUpScreen();
            } else {
              return const HomePage();
            }
          },
          error: (error, stactTrace) => const SizedBox(),
          loading: () => const LoadingIndicator()),
    );
  }
}

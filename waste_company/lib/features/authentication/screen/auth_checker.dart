import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waste_company/features/authentication/screen/sign_up.dart';
import 'package:waste_company/features/home/home_page.dart';
import 'package:waste_company/utils/loading_alert.dart';

import '../../../api/providers.dart';

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

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:waste_company/features/authentication/controller/auth_controller.dart';

import '../../../routes/route_path.dart';
import '../../../theme/app_color.dart';
import '../../../utils/loading_alert.dart';
import '../widget/auth_button.dart';
import '../widget/custom_auth_field.dart';

class SignInScreen extends StatefulHookConsumerWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final textTheme = Theme.of(context).textTheme;
    final authController = ref.watch(authControllerProvider.notifier);

    final authControllerState = ref.watch(authControllerProvider);
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: authControllerState
                ? const LoadingIndicator()
                : SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Text('Sign In',
                              style: textTheme.displayLarge!.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: 30,
                              )),
                          const SizedBox(height: 40),
                          CustomAuthField(
                            controller: emailController,
                            hintText: 'Email',
                            leadingIcon: Icons.email,
                            isEmail: true,
                          ),
                          CustomAuthField(
                            controller: passwordController,
                            hintText: 'Password',
                            leadingIcon: Icons.lock,
                          ),
                          const SizedBox(height: 40),
                          AuthButton(
                            title: 'SignIn',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                authController.signIn(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context);
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Not a contributor? ',
                                  style: textTheme.displaySmall!.copyWith(
                                      color: AppColors.secondaryColor)),
                              TextButton(
                                  onPressed: () =>
                                      context.goNamed(RoutePath.signUp),
                                  child: Text('Sign Up',
                                      style: textTheme.displaySmall))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

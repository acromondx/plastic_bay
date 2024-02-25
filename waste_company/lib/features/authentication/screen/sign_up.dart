import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:waste_company/routes/route_path.dart';
import 'package:waste_company/utils/loading_alert.dart';

import '../../../theme/app_color.dart';
import '../../../utils/toast_message.dart';
import '../controller/auth_controller.dart';
import '../widget/auth_button.dart';
import '../widget/custom_auth_field.dart';

class SignUpScreen extends StatefulHookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    requestLocationPermission();
    super.initState();
  }

  requestLocationPermission() async {
    await Geolocator.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final phoneController = useTextEditingController();
    final companyController = useTextEditingController();
    final textTheme = Theme.of(context).textTheme;
    final authController = ref.watch(authControllerProvider.notifier);
    final authControllerState = ref.watch(authControllerProvider);
    return Scaffold(
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Sign Up',
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
                          controller: phoneController,
                          hintText: 'Phone',
                          isPasswordField: false,
                          leadingIcon: Icons.phone,
                        ),
                        CustomAuthField(
                          controller: companyController,
                          hintText: 'Company Name',
                          isPasswordField: false,
                          leadingIcon: Icons.business,
                        ),
                        CustomAuthField(
                          controller: passwordController,
                          hintText: 'Password',
                          leadingIcon: Icons.lock,
                          isPasswordField: true,
                        ),
                        const SizedBox(height: 40),
                        AuthButton(
                            title: 'Sign Up',
                            onPressed: () {
                              if (!EmailValidator.validate(
                                      emailController.text) ||
                                  passwordController.text.length < 7 ||
                                  companyController.text.isEmpty ||
                                  phoneController.text.isEmpty) {
                                showToastMessage('All field required', context);
                              } else {
                                authController.register(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  companyName: companyController.text,
                                  phoneNumber: int.parse(phoneController.text),
                                  context: context,
                                );
                              }
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Got an account? ',
                                style: textTheme.displaySmall!
                                    .copyWith(color: AppColors.secondaryColor)),
                            TextButton(
                                onPressed: () =>
                                    context.goNamed(RoutePath.signIn),
                                child: Text('Sign In',
                                    style: textTheme.displaySmall))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

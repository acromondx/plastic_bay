import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plastic_bay/constants/ui/svgs.dart';
import 'package:plastic_bay/features/authentication/controler/auth_controller.dart';
import 'package:plastic_bay/features/authentication/controler/auth_state.dart';
import 'package:plastic_bay/routes/route_path.dart';
import 'package:plastic_bay/theme/app_color.dart';
import 'package:plastic_bay/utils/loading_alert.dart';
import 'package:plastic_bay/utils/reuseables.dart';

import '../widget/auth_button.dart';
import '../../../utils/toast_message.dart';
import '../widget/custom_auth_field.dart';
import '../widget/social_signin_buttons.dart';

class SignUpScreen extends StatefulHookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpScreen> {
  String image = '';
  bool picked = false;

  @override
  void initState() {
    requestLocationPermission();
    super.initState();
  }

  requestLocationPermission() async {
    final permission = await Permission.location.serviceStatus;
    if (permission.isDisabled) {
      await Geolocator.requestPermission();
    } else {
      return;
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final nameController = useTextEditingController();
    final textTheme = Theme.of(context).textTheme;
    final authController = ref.watch(authControllerProvider.notifier);
    final authControllerState = ref.watch(authControllerProvider);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: authControllerState
            ? const SizedBox.shrink()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SocialSignInButton(
                      isGoogle: true,
                      onPressed: () => authController.googleSignIn(context),
                    ),
                    const SizedBox(width: 10),
                    SocialSignInButton(
                      isGoogle: false,
                      onPressed: () => authController.appleSignIn(context),
                    )
                  ],
                ),
              ),
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
                          // Text('Register Now Let\'s make the world plastic free!',
                          //     style: textTheme.titleLarge!.copyWith(
                          //       fontWeight: FontWeight.bold,
                          //     )),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomAuthField(
                            controller: emailController,
                            hintText: 'Email',
                            leadingSvg: AppSvg.mailLight,
                          ),
                          CustomAuthField(
                            controller: nameController,
                            hintText: 'Name',
                            leadingSvg: AppSvg.userBold,
                          ),
                          CustomAuthField(
                            controller: passwordController,
                            hintText: 'Password',
                            isPasswordField: true,
                            leadingSvg: AppSvg.lockBold,
                          ),
                          GestureDetector(
                            onTap: () => pickImage().then((value) {
                              setState(() {
                                image = value;
                                picked = true;
                              });
                            }),
                            child: Align(
                                alignment: Alignment.center,
                                child: image.isEmpty
                                    ? DottedBorder(
                                        radius: const Radius.circular(20),
                                        color: AppColors.primaryColor,
                                        strokeWidth: 1,
                                        dashPattern: const [2, 5],
                                        stackFit: StackFit.loose,
                                        child: Container(
                                          color: Colors.grey.withOpacity(0.1),
                                          height: 100,
                                          width: size.width - 100,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.cloud_upload_rounded,
                                                color: AppColors.primaryColor,
                                              ),
                                              Text('Upload profile photo',
                                                  style: textTheme.displaySmall)
                                            ],
                                          ),
                                        ))
                                    : SizedBox(
                                        height: 100,
                                        width: size.width - 100,
                                        child: Image.file(File(image)),
                                      )),
                          ),
                          const SizedBox(height: 40),
                          AuthButton(
                              title: 'Sign Up',
                              onPressed: () {
                                if (formKey.currentState!.validate() ||
                                    image.isEmpty) {
                                  showToastMessage(
                                      'All fields are required', context);
                                  return;
                                } else {
                                  authController.register(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      imagePath: image,
                                      context: context);
                                }
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Got an account? ',
                                  style: textTheme.displaySmall!.copyWith(
                                      color: AppColors.secondaryColor)),
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
      ),
    );
  }
}

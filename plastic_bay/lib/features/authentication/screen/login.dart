import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plastic_bay/features/authentication/widget/auth_button.dart';
import 'package:plastic_bay/routes/route_path.dart';
import '../../../constants/ui/svgs.dart';
import '../../../theme/app_color.dart';
import '../../../utils/loading_alert.dart';
import '../controler/auth_controller.dart';
import '../widget/custom_auth_field.dart';
import '../widget/social_signin_buttons.dart';

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
      child: Scaffold(
        bottomNavigationBar:authControllerState
            ? const SizedBox.shrink()
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                onPressed: () => authController.googleSignIn(context),
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
                    CustomAuthField(
                      controller: emailController,
                      hintText: 'Email',
                      leadingSvg: AppSvg.mailLight,
                    ),
                    CustomAuthField(
                      controller: passwordController,
                      hintText: 'Password',
                      leadingSvg: AppSvg.userBold,
                    ),
                    const SizedBox(height: 40),
                    AuthButton(
                      title: 'SignIn',
                      onPressed: () {
                         if(formKey.currentState!.validate()){
                           authController.signIn(email: emailController.text, password:passwordController.text , context: context);
                         }  
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not a contributor? ',
                            style: textTheme.displaySmall!
                                .copyWith(color: AppColors.secondaryColor)),
                        TextButton(
                            onPressed: () => context.goNamed(RoutePath.signUp),
                            child: Text('Sign Up', style: textTheme.displaySmall))
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

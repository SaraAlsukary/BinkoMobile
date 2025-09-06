import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:binko/features/auth/presentation/pages/register_screen.dart';
import 'package:binko/features/main/presentation/pages/main_screen.dart';
import 'package:binko/features/profile/presentation/pages/profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/validation.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/services/dependecies.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: getIt<AuthBloc>(),
      listener: (context, state) {
        if (state.status == RequestStatus.success) {
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ScaleTransition(
                scale: animation,
                child: MainScreen(),
              ),
            ),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                .1.sh.verticalSpace,
                FractionallySizedBox(
                  widthFactor: .7,
                  child: LottieBuilder.asset(
                    Assets.assetsLottieFilesFlyingBook,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                80.verticalSpace,
                MainTextField(
                  label: 'auth.email'.tr(),
                  hint: 'auth.email_hint'.tr(),
                  controller: emailController,
                  validator: (p0) => p0?.isValidEmail() ?? false
                      ? null
                      : 'auth.validation.invalid_email'.tr(),
                ),
                20.verticalSpace,
                MainTextField(
                  label: 'auth.password'.tr(),
                  hint: 'auth.password_hint'.tr(),
                  isPassword: true,
                  controller: passwordController,
                  validator: (p0) => p0?.isValidPassword() ?? false
                      ? null
                      : 'auth.validation.invalid_password'.tr(),
                ),
                20.verticalSpace,
                MainButton(
                    text: 'auth.login'.tr(),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        getIt<AuthBloc>().add(LoginEvent(
                            username: emailController.text,
                            password: passwordController.text));
                      }
                    }),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('auth.dont_have_account'.tr()),
                    Text(
                      'auth.join_now'.tr(),
                      style: context.textTheme.titleSmall?.copyWith(
                          color: context.primaryColor,
                          fontWeight: FontWeight.bold),
                    ).onTap(() {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ScaleTransition(
                            scale: animation,
                            child: RegisterScreen(),
                          ),
                        ),
                        // (route) => false,
                      );
                      // Navigator.pushReplacement(
                      //     context,
                      //     PageTransition(
                      //         type: PageTransitionType.bottomToTop,
                      //         child: RegisterScreen()));
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

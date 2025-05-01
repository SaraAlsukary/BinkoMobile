import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:binko/features/main/presentation/pages/main_screen.dart';
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
                  label: 'E-mail',
                  hint: 'example@mail.com',
                  controller: emailController,
                  validator: (p0) => p0?.isValidEmail() ?? false
                      ? null
                      : 'Please Add A Valid Email',
                ),
                20.verticalSpace,
                MainTextField(
                  label: 'Password',
                  hint: '*******',
                  isPassword: true,
                  controller: passwordController,
                  validator: (p0) => p0?.isValidPassword() ?? false
                      ? null
                      : 'Please Add A Valid Password',
                ),
                20.verticalSpace,
                MainButton(
                    text: 'Login',
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
                    Text('Don\'t Have Account?'),
                    Text(
                      'Join Now',
                      style: context.textTheme.titleSmall?.copyWith(
                          color: context.primaryColor,
                          fontWeight: FontWeight.bold),
                    ).onTap(() {
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ScaleTransition(
                            scale: animation,
                            child: MainScreen(),
                          ),
                        ),
                        (route) => false,
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

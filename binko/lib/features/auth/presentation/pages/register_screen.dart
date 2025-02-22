import 'package:binko/core/constants/assets.dart';
import 'package:binko/core/extensions/context_extensions.dart';
import 'package:binko/core/extensions/validation.dart';
import 'package:binko/core/extensions/widget_extensions.dart';
import 'package:binko/core/widgets/main_button.dart';
import 'package:binko/core/widgets/main_text_field.dart';
import 'package:binko/features/auth/presentation/pages/login_screen.dart';
import 'package:binko/features/main/presentation/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              MainTextField(
                label: 'User Name',
                hint: 'User Name',
                controller: nameController,
                validator: (p0) =>
                    p0?.isNotShortText() ?? false ? null : 'Please Add A Name',
              ),
              20.verticalSpace,
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
                controller: passwordController,
                isPassword: true,
                validator: (p0) => p0?.isValidPassword() ?? false
                    ? null
                    : 'Please Add A Valid Password',
              ),
              20.verticalSpace,
              MainTextField(
                label: 'Confirm Password',
                isPassword: true,
                hint: '********',
                controller: confirmPasswordController,
                validator: (p0) =>
                    p0?.isValidEmail() ?? false ? null : 'Password Mismatch',
              ),
              20.verticalSpace,
              MainButton(
                  text: 'Register',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          ));
                    }
                  }),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already Have an Account?'),
                  Text(
                    'Login',
                    style: context.textTheme.titleSmall?.copyWith(
                        color: context.primaryColor,
                        fontWeight: FontWeight.bold),
                  ).onTap(() {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: LoginScreen()));
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

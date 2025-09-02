import 'package:binko/core/services/dependecies.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:binko/features/auth/presentation/pages/complete_information_user_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/validation.dart';
import '../../../../core/extensions/widget_extensions.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_text_field.dart';
import 'login_screen.dart';

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

  late final AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = getIt<AuthBloc>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
                label: 'auth.username'.tr(),
                hint: 'auth.username_hint'.tr(),
                controller: nameController,
                validator: (p0) => p0?.isNotShortText() ?? false
                    ? null
                    : 'auth.validation.required_name'.tr(),
              ),
              20.verticalSpace,
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
                controller: passwordController,
                isPassword: true,
                validator: (p0) => p0?.isValidPassword() ?? false
                    ? null
                    : 'auth.validation.invalid_password'.tr(),
              ),
              20.verticalSpace,
              MainTextField(
                label: 'auth.confirm_password'.tr(),
                isPassword: true,
                hint: 'auth.confirm_password_hint'.tr(),
                controller: confirmPasswordController,
                validator: (p0) => p0 != null && p0 == passwordController.text
                    ? null
                    : 'auth.validation.password_mismatch'.tr(),
              ),
              20.verticalSpace,
              BlocConsumer<AuthBloc, AuthState>(
                bloc: authBloc,
                listener: (context, state) {
                  if (state.status == RequestStatus.success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const CompleteInformationUserPage()),
                    );
                  } else if (state.status == RequestStatus.failed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to register")),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state.status == RequestStatus.loading;
                  return MainButton(
                    text: 'auth.register'.tr(),
                    onPressed: isLoading
                        ? null
                        : () {
                      if (formKey.currentState!.validate()) {
                        authBloc.add(CreateUserEvent(
                          name: nameController.text,
                          username: emailController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                        ));
                      }
                    },
                  );
                },
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('auth.already_have_account'.tr()),
                  Text(
                    'auth.login'.tr(),
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

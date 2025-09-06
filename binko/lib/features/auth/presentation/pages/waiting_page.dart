import 'package:binko/features/auth/presentation/pages/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:binko/core/constants/assets.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                Assets.assetsLottieFilesFlyingBook,
                width: 200.w,
              ),
              SizedBox(height: 20.h),
              Text(
                "waiting.title".tr(),
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                "waiting.description".tr(),
                style: TextStyle(fontSize: 20.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                "waiting.description2".tr(),
                style: TextStyle(fontSize: 20.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

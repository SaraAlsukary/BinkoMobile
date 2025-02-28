import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../constants/assets.dart';
import '../extensions/context_extensions.dart';

class Toaster {
  Toaster._();

  static void showToast(String text, {bool isError = true}) {
    BotToast.showCustomText(toastBuilder: (cancelFunc) {
      return Card(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isError ? Icons.warning_amber_rounded : Icons.done,
                color: isError ? const Color(0xff9F1C48) : Colors.green,
                size: 30.sp),
            const SizedBox(width: 10),
            Expanded(
              child: Text(text,
                  style: TextStyle(
                    color: isError ? const Color(0xff9F1C48) : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 5),
            ),
          ],
        ),
      ));
    });
  }

  static void showLoading() {
    BotToast.showCustomLoading(
        animationDuration: Durations.medium1,
        toastBuilder: (cancelFunc) {
          return Builder(builder: (context) {
            return Card(
              color: context.scaffoldBackgroundColor,
              child: Container(
                width: 100.w,
                padding: EdgeInsets.all(6.sp),
                child: const CustomLoadingWidget(),
              ),
            ).animate().scale();
          });
        });
  }

  static void closeLoading() {
    BotToast.closeAllLoading();
  }
}

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
    this.width,
    this.height,
  });
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      Assets.assetsLottieFilesLoading,
      repeat: true,
      animate: true,
      width: width,
      height: height,
      fit: BoxFit.fitWidth,
    );
  }
}

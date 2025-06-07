import 'package:binko/core/services/shared_preferences_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/constants/assets.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../auth/presentation/pages/register_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      initialPage: 0,
      showDoneButton: true,
      onDone: () async {
        await SharedPreferencesService.storeFirstTimeQoutation();
        Navigator.pushReplacement(
            context,
            PageTransition(
                alignment: Alignment.bottomCenter,
                type: PageTransitionType.scale,
                child: RegisterScreen()));
      },
      showNextButton: true,
      showSkipButton: true,
      skip: Text('onboarding.skip'.tr()),
      next: Text('onboarding.next'.tr()),
      done: Text('onboarding.done'.tr()),
      // globalBackgroundColor: context.primaryColor,
      nextStyle: TextButton.styleFrom(foregroundColor: Colors.black),
      skipStyle: TextButton.styleFrom(foregroundColor: Colors.black),
      doneStyle: TextButton.styleFrom(foregroundColor: Colors.black),
      dotsDecorator: DotsDecorator(
          activeShape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
          activeColor: Colors.black,
          activeSize: Size(20, 20)),
      pages: [
        PageViewModel(
            title: 'onboarding.title'.tr(),
            body: 'onboarding.description'.tr(),
            decoration: PageDecoration(
                pageMargin: EdgeInsets.all(10),
                boxDecoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.assetsImgsBackground),
                        colorFilter: ColorFilter.mode(
                            context.primaryColor, BlendMode.srcIn)))),
            image: Image.asset(Assets.assetsImgsIntro)),
        PageViewModel(
            title: 'onboarding.title'.tr(),
            body: 'onboarding.description'.tr(),
            decoration: PageDecoration(
                pageMargin: EdgeInsets.all(10),
                boxDecoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.assetsImgsBackground),
                        colorFilter: ColorFilter.mode(
                            context.primaryColor, BlendMode.srcIn)))),
            image: Image.asset(Assets.assetsImgsBook)),
        PageViewModel(
            title: 'onboarding.title'.tr(),
            body: 'onboarding.description'.tr(),
            decoration: PageDecoration(
                pageMargin: EdgeInsets.all(10),
                boxDecoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Assets.assetsImgsBackground),
                        colorFilter: ColorFilter.mode(
                            context.primaryColor, BlendMode.srcIn)))),
            image: Image.asset(Assets.assetsImgsLogo,
                width: .6.sw, fit: BoxFit.fitWidth))
      ],
    );
  }
}

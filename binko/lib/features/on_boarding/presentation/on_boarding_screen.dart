import 'package:binko/core/constants/assets.dart';
import 'package:binko/core/extensions/context_extensions.dart';
import 'package:binko/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

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
      onDone: () {
        Navigator.pushReplacement(
            context,
            PageTransition(
                alignment: Alignment.bottomCenter,
                type: PageTransitionType.scale,
                child: RegisterScreen()));
      },
      showNextButton: true,
      showSkipButton: true,
      skip: Text('Skip'),
      next: Text('Next'),
      // globalBackgroundColor: context.primaryColor,
      done: Text('Done'),

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
            title: 'Binko',
            body: 'Binko Is Your Friend',
            decoration: PageDecoration(
                pageMargin: EdgeInsets.all(10),
                boxDecoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          Assets.assetsImgsBackground,
                        ),
                        colorFilter: ColorFilter.mode(
                            context.primaryColor, BlendMode.srcIn)))),
            image: Image.asset(Assets.assetsImgsIntro)),
        PageViewModel(
            decoration: PageDecoration(
                pageMargin: EdgeInsets.all(10),
                boxDecoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          Assets.assetsImgsBackground,
                        ),
                        colorFilter: ColorFilter.mode(
                            context.primaryColor, BlendMode.srcIn)))),
            title: 'Binko',
            body: 'Binko Is Your Friend',
            image: Image.asset(Assets.assetsImgsBook)),
        PageViewModel(
            decoration: PageDecoration(
                pageMargin: EdgeInsets.all(10),
                boxDecoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          Assets.assetsImgsBackground,
                        ),
                        colorFilter: ColorFilter.mode(
                            context.primaryColor, BlendMode.srcIn)))),
            title: 'Binko',
            body: 'Binko Is Your Friend',
            image: Image.asset(
              Assets.assetsImgsLogo,
              width: .6.sw,
              fit: BoxFit.fitWidth,
            ))
      ],
    );
  }
}

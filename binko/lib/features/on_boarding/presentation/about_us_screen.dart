import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/assets.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/widgets/main_button.dart';
import 'on_boarding_screen.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: context.theme.primaryColor,
              child: LottieBuilder.asset(Assets.assetsLottieFilesBooksAbout),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'welcome.title'.tr(),
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'welcome.description'.tr(),
                      maxLines: 6,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  MainButton(
                      color: context.primaryColor,
                      text: 'welcome.start_journey'.tr(),
                      fontSize: 24,
                      fontFamily: 'LoveYa',
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnBoardingScreen(),
                            ));
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

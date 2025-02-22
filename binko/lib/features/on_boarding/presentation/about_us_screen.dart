import 'package:binko/core/constants/assets.dart';
import 'package:binko/core/extensions/context_extensions.dart';
import 'package:binko/core/widgets/main_button.dart';
import 'package:binko/features/on_boarding/presentation/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
                      'Welcome To Binko!',
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      'This Community Provides you many wonderful books in different categories, and make it possible to interact with this books ,add your comments that show your point of view!. We wish you like it',
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
                      text: 'Start Journy',
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

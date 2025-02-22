import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:binko/core/constants/assets.dart';
import 'package:binko/core/cubit/theme_cubit.dart';
import 'package:binko/core/extensions/context_extensions.dart';
import 'package:binko/core/services/dependecies.dart';
import 'package:binko/features/on_boarding/presentation/about_us_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

import 'core/services/shared_preferences_service.dart';
import 'core/utils/theme/light/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  try {
    await Future.wait([
      SharedPreferencesService.init(),
      EasyLocalization.ensureInitialized(),
    ]);
  } catch (e) {}
  getIt<ThemeCubit>().getTheme();

  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('ku'),
        Locale('tr'),
      ],
      startLocale: const Locale('en'),
      saveLocale: true,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        enableScaleText: () => false,
        fontSizeResolver: (fontSize, instance) {
          return fontSize.toDouble();
        },
        designSize: const Size(414, 930),
        child: SafeArea(
            top: false,
            child: BlocBuilder<ThemeCubit, ThemeState>(
                bloc: getIt<ThemeCubit>(),
                builder: (context, state) {
                  return ThemeProvider(
                      initTheme: (state is DarkTheme)
                          ? MaterialTheme(
                              'Leckerli',
                            ).dark()
                          : MaterialTheme(
                              'Leckerli',
                            ).light(),
                      builder: (context, theme) => MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaler: TextScaler.noScaling),
                            child: MaterialApp(
                              theme: theme,
                              home: const SplashScreen(),
                            ),
                          ));
                })));
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor,
      body: Container(
          child: Center(
        child: Image.asset(
          Assets.assetsImgsLogo,
          color: Colors.white,
          width: .5.sw,
          fit: BoxFit.fitWidth,
        ),
      )
              .animate(
                onComplete: (controller) {
                  controller.repeat(count: 2).then((v) {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.theme,
                        child: AboutUsScreen(),
                      ),
                    );
                  });
                },
              )
              .fadeIn(duration: Durations.extralong2)
              .fadeOut(delay: Durations.extralong2, duration: Durations.long3)),
    );
  }
}

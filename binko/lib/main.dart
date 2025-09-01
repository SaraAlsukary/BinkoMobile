import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:binko/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:binko/features/auth/presentation/pages/register_screen.dart';
import 'package:binko/features/on_boarding/presentation/about_us_screen.dart';
import 'package:binko/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/constants/assets.dart';
import 'core/cubit/theme_cubit.dart';
import 'core/extensions/context_extensions.dart';
import 'core/services/dependecies.dart';
import 'core/services/shared_preferences_service.dart';
import 'core/utils/request_status.dart';
import 'core/utils/theme/light/light_theme.dart';
import 'features/main/presentation/pages/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPreferencesService.init();
  final tempDir = await getTemporaryDirectory();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(tempDir.path));
  configureDependencies();
  getIt<ThemeCubit>().getTheme();

  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('en'),
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
              print(state);
              return ThemeProvider(
                  initTheme: (state is DarkTheme)
                      ? MaterialTheme(
                          'Markazi',
                        ).dark()
                      : MaterialTheme(
                          'Markazi',
                        ).light(),
                  builder: (context, theme) => MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaler: TextScaler.noScaling),
                        child: MaterialApp(
                          builder: BotToastInit(),
                          supportedLocales: context.supportedLocales,
                          locale: context.locale,
                          localizationsDelegates: context.localizationDelegates,
                          navigatorObservers: [BotToastNavigatorObserver()],
                          theme: theme,
                          home: const SplashScreen(),
                        ),
                      ));
            }),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
    return BlocListener<AuthBloc, AuthState>(
      bloc: getIt<AuthBloc>(),
      listener: (context, state) {
        if (state.status == RequestStatus.success) {
          getIt<ProfileBloc>().add(GetFavoredBooks());
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
        } else {
          if (SharedPreferencesService.getFirstTimeQoutation()) {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ScaleTransition(
                    scale: animation,
                    child: RegisterScreen(),
                  ),
                ));
          } else {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ScaleTransition(
                    scale: animation,
                    child: AboutUsScreen(),
                  ),
                ));
          }
        }
      },
      child: Scaffold(
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
                      getIt<AuthBloc>().add(CheckAuthEvent());
                    });
                  },
                )
                .fadeIn(duration: Durations.extralong2)
                .fadeOut(
                    delay: Durations.extralong2, duration: Durations.long3)),
      ),
    );
  }
}

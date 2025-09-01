import "package:flutter/material.dart";
import "package:flutter/services.dart";

class MaterialTheme {
  final String fontFamily;

  const MaterialTheme(this.fontFamily);

  static ColorScheme lightScheme() {
    return const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 29, 175, 18),
        surfaceTint: Color.fromARGB(255, 29, 175, 18),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xffffffff),
        onPrimaryContainer: Color(0xff2f1800),
        secondary: Color.fromARGB(255, 29, 175, 18),
        onSecondary: Color(0xffffffff),
        secondaryContainer: Color(0xffffffff),
        onSecondaryContainer: Color(0xff2f1800),
        tertiary: Color.fromARGB(255, 29, 175, 18),
        onTertiary: Color(0xffffffff),
        tertiaryContainer: Color(0xffffffff),
        onTertiaryContainer: Color(0xff2f1800),
        error: Color(0xffb32d56),
        onError: Color(0xffffffff),
        errorContainer: Color(0xffb32d56),
        onErrorContainer: Color(0xffffffff),
        surface: Color(0xffffffff),
        onSurface: Color(0xff1c1b1b),
        onSurfaceVariant: Color(0xff444748),
        outline: Color(0xff747878),
        outlineVariant: Color(0xffc4c7c8),
        shadow: Color.fromARGB(117, 35, 35, 35),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xff313030),
        inversePrimary: Color(0xffecbe91),
        primaryFixed: Color(0xffffdcbd),
        onPrimaryFixed: Color(0xff2c1600),
        primaryFixedDim: Color(0xffecbe91),
        onPrimaryFixedVariant: Color(0xff60401d),
        secondaryFixed: Color(0xffffdcbd),
        onSecondaryFixed: Color(0xff2c1600),
        secondaryFixedDim: Color(0xffecbe91),
        onSecondaryFixedVariant: Color(0xff60401d),
        tertiaryFixed: Color(0xffffdcbd),
        onTertiaryFixed: Color(0xff2c1600),
        tertiaryFixedDim: Color(0xffecbe91),
        onTertiaryFixedVariant: Color(0xff60401d),
        surfaceDim: Color(0xffddd9d9),
        surfaceBright: Color(0xfffcf8f8),
        surfaceContainerLowest: Color(0xffffffff),
        surfaceContainerLow: Color(0xfff6f3f2),
        surfaceContainer: Color(0xfff1edec),
        surfaceContainerHigh: Color(0xffF0F0F0),
        surfaceContainerHighest: Color(0xffe5e2e1),
        onInverseSurface: Color.fromARGB(255, 182, 182, 23));
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      onInverseSurface: Color.fromARGB(255, 182, 182, 23),
      primary: Color.fromARGB(255, 29, 175, 18),
      surfaceTint: Color.fromARGB(255, 29, 175, 18),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2f1800),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color.fromARGB(255, 29, 175, 18),
      onSecondary: Color(0xff232323),
      secondaryContainer: Color(0xff232323),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color.fromARGB(255, 29, 175, 18),
      onTertiary: Color(0xff232323),
      tertiaryContainer: Color(0xff232323),
      onTertiaryContainer: Color(0xff232323),
      error: Color(0xffb32d56),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffb32d56),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xff1a1a1a),
      onSurface: Color(0xffe0e0e0),
      onSurfaceVariant: Color(0xffe0e0e0),
      outline: Color(0xff747878),
      outlineVariant: Color(0xffc4c7c8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffffffff),
      inversePrimary: Color(0xffecbe91),
      primaryFixed: Color(0xffffdcbd),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xffecbe91),
      onPrimaryFixedVariant: Color(0xff60401d),
      secondaryFixed: Color(0xffffdcbd),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xffecbe91),
      onSecondaryFixedVariant: Color(0xff60401d),
      tertiaryFixed: Color(0xffffdcbd),
      onTertiaryFixed: Color(0xff2c1600),
      tertiaryFixedDim: Color(0xffecbe91),
      onTertiaryFixedVariant: Color(0xff60401d),
      surfaceDim: Color(0xff121212),
      surfaceBright: Color(0xff1e1e1e),
      surfaceContainerLowest: Color(0xff0d0d0d),
      surfaceContainerLow: Color(0xff161616),
      surfaceContainer: Color(0xff1a1a1a),
      surfaceContainerHigh: Color(0xff202020),
      surfaceContainerHighest: Color(0xff252525),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) {
    const darkTextTheme = TextTheme(
      displayLarge: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 56,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      displayMedium: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 46,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      displaySmall: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 36,
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      headlineLarge: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 32,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      headlineMedium: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 28,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      headlineSmall: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 24,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      titleLarge: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 22,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      titleMedium: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 19,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      titleSmall: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 16,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      bodyLarge: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 16,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      bodyMedium: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 14,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      bodySmall: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 12,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      labelLarge: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 14,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      labelMedium: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 12,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
      labelSmall: TextStyle(
          fontFamilyFallback: [
            'Roboto',
            'NRT',
            'Tajawal',
            'SF Pro Text',
            'Rudaw'
          ],
          fontSize: 11,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
          color: Colors.white),
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      fontFamilyFallback: const [
        'Roboto',
        'NRT',
        'Tajawal',
        'SF Pro Text',
        'Rudaw'
      ],
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (context) =>
            Icon(Icons.arrow_back_ios_new_outlined, color: colorScheme.primary),
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xff202020),
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      primaryColor: colorScheme.primary,
      textTheme: darkTextTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface),
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
    );
  }

  /// AppBarBackground
  static const appBarBackground = ExtendedColor(
    seed: Color(0xff202020),
    value: Color(0xff202020),
    light: ColorFamily(
      color: Color(0xff0c0d0d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff2d2d2d),
      onColorContainer: Color(0xffbcb9b9),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff0c0d0d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff2d2d2d),
      onColorContainer: Color(0xffbcb9b9),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff0c0d0d),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff2d2d2d),
      onColorContainer: Color(0xffbcb9b9),
    ),
    dark: ColorFamily(
      color: Color(0xffc8c6c5),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff181818),
      onColorContainer: Color(0xffa5a3a3),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffc8c6c5),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff181818),
      onColorContainer: Color(0xffa5a3a3),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffc8c6c5),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff181818),
      onColorContainer: Color(0xffa5a3a3),
    ),
  );

  /// HomeCategoryBackground
  static const homeCategoryBackground = ExtendedColor(
    seed: Color(0xff343434),
    value: Color(0xff343434),
    light: ColorFamily(
      color: Color(0xff222222),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff434343),
      onColorContainer: Color(0xffdcdad9),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff222222),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff434343),
      onColorContainer: Color(0xffdcdad9),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff222222),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xff434343),
      onColorContainer: Color(0xffdcdad9),
    ),
    dark: ColorFamily(
      color: Color(0xffc8c6c6),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff2b2b2b),
      onColorContainer: Color(0xffb9b7b7),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffc8c6c6),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff2b2b2b),
      onColorContainer: Color(0xffb9b7b7),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffc8c6c6),
      onColor: Color(0xff303030),
      colorContainer: Color(0xff2b2b2b),
      onColorContainer: Color(0xffb9b7b7),
    ),
  );

  List<ExtendedColor> get extendedColors => [
        appBarBackground,
        homeCategoryBackground,
      ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

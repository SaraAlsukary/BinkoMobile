import 'package:flutter/material.dart';

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme textTheme = baseTextTheme.copyWith(
    bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w900),
    bodyMedium: baseTextTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w900),
    bodySmall: baseTextTheme.bodySmall?.copyWith(fontWeight: FontWeight.w900),
    labelLarge: baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.w900),
    labelMedium:
        baseTextTheme.labelMedium?.copyWith(fontWeight: FontWeight.w900),
    labelSmall: baseTextTheme.labelSmall?.copyWith(fontWeight: FontWeight.w900),
  );
  return textTheme;
}

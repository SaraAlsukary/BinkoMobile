import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/context_extensions.dart';
import '../extensions/widget_extensions.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.eleavation,
    required this.text,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textColor,
    required this.onPressed,
    this.borderRadius,
    this.shadowColor,
    this.borderColor,
    this.hasBorder = false,
    this.icon,
    this.fontFamily,
  });

  final double? eleavation;
  final String text;
  final double? width;
  final double? height;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? textColor;
  final VoidCallback? onPressed;
  final BorderRadiusGeometry? borderRadius;
  final Color? shadowColor;
  final Color? borderColor;
  final Widget? icon;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            side: hasBorder
                ? BorderSide(
                    width: 1.5,
                    color: borderColor ??
                        const Color(0xff4C341D).withValues(alpha: 125),
                  )
                : BorderSide.none,
          ),
        ),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        backgroundColor: WidgetStatePropertyAll(
            color ?? context.theme.colorScheme.onInverseSurface),
        elevation: WidgetStatePropertyAll(eleavation ?? 1),
        fixedSize: WidgetStateProperty.all(
          Size(
            width ?? .2.sw,
            height ?? 48.h,
          ),
        ),
      ),
      onPressed: (onPressed != null)
          ? () {
              FocusManager.instance.primaryFocus?.unfocus();
              onPressed!();
            }
          : null,
      child: Container(
        width: width ?? double.maxFinite,
        height: height ?? 48.h,
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            border: hasBorder
                ? Border(
                    top: BorderSide(
                        color: Colors.white.withValues(alpha: .5), width: 2.2),
                    right: BorderSide(
                        color: Colors.white.withValues(alpha: .5), width: 2.2),
                    left: BorderSide(
                        color: Colors.white.withValues(alpha: .5), width: 2.2))
                : null),
        child: SizedBox(
          width: width,
          height: height ?? 48.h,
          child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) icon!,
                  Text(
                    text,
                    maxLines: 1,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: textColor ?? Colors.black,
                      fontFamily: fontFamily,
                      fontWeight: fontWeight ?? FontWeight.w400,
                      fontSize:
                          fontSize ?? context.textTheme.titleMedium?.fontSize,
                    ),
                  )
                ],
              ).paddingSymmetric(horizontal: 20, vertical: 8)),
        ),
      ),
    );
  }
}

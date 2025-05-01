// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:binko/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class MultiColorBorderContainer extends StatelessWidget {
  const MultiColorBorderContainer({
    super.key,
    required this.child,
    this.color,
    this.width,
    this.height,
  });
  final Widget child;
  final Color? color;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          width: 5, // Border thickness
          color: Colors.transparent, // Make border transparent
        ),
      ),
      child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [
                context.primaryColor,
                context.theme.colorScheme.error,
                context.theme.colorScheme.onInverseSurface,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                  child: Center(child: child)),
            ),
          )),
    );
  }
}

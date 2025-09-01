import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../extensions/context_extensions.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape,
  });

  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: context.theme.highlightColor,
        direction: ShimmerDirection.ttb,
        period: Durations.extralong1,
        highlightColor: context.theme.cardColor,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              shape: shape ?? BoxShape.rectangle,
              color: context.theme.highlightColor,
              borderRadius: BorderRadius.circular(borderRadius ?? 12)),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension StringParser on String {
  Color toColor() {
    String hashColor = replaceAll("#", "0xff");
    return Color(int.parse(hashColor));
  }

  String parseUnicode() {
    return split("\\u").length == 1
        ? this
        : String.fromCharCodes([int.parse(split('\\u').last, radix: 16)]);
  }

  Color parseRgbString() {
    // Remove "rgb(" and ")" and split by commas
    List<String> values = replaceAll("rgb(", "").replaceAll(")", "").split(",");

    // Parse each component to int
    int r = int.parse(values[0].trim());
    int g = int.parse(values[1].trim());
    int b = int.parse(values[2].trim());

    return Color.fromARGB(255, r, g, b); // Full opacity
  }

  double toDouble() {
    return double.tryParse(this) ?? 0;
  }

  Widget toSvg(
      {ColorFilter? color, double? width, double? height, BoxFit? fit}) {
    return SvgPicture.asset(
      this,
      colorFilter: color,
      matchTextDirection: true,
      fit: fit ?? BoxFit.scaleDown,
      width: width ?? 25,
      height: height ?? 25,
    );
  }
}

extension ColorParser on Color {
  String toHex() {
    return value.toRadixString(16).replaceRange(0, 2, "#");
  }
}

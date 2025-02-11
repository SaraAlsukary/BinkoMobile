import 'dart:math';

extension NumExtension on num {
  String formatDecimal({int afterPoint = 2}) {
    if ((this - floor()) < 10 ^ (-afterPoint)) {
      return toStringAsFixed(0); // No decimal point
    } else {
      return toStringAsFixed(afterPoint);
    }
  }

  String formatNumber() {
    String fixed = toStringAsFixed(16);
    int digitsAfterDecimal = fixed.contains(".")
        ? fixed.split(".")[1].replaceAll(RegExp(r'0*$'), '').length
        : 0;
    if (digitsAfterDecimal <= 4) {
      return toStringAsFixed(4)
          .replaceAll(RegExp(r'0*$'), '')
          .replaceAll(RegExp(r'\.$'), '');
    } else {
      int exponent = (log(this) / ln10).floor();
      int engineeringExponent = (exponent ~/ 3) * 3;
      double mantissa = this / pow(10, engineeringExponent);
      return '${mantissa.toStringAsFixed(2)} x 10^$engineeringExponent';
    }
    // int exponent = (log(this) / ln10).floor();
    // int engineeringExponent = (exponent ~/ 3) * 3;
    // double mantissa = this / pow(10, engineeringExponent);
    // return '${mantissa.toStringAsFixed(2)} x 10^$engineeringExponent';
  }
}

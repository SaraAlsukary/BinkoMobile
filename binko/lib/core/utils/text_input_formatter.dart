import 'package:flutter/services.dart';

class CertificateNumberFormatter extends TextInputFormatter {
  final int currentYear = DateTime.now().year;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-digit characters
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Add formatting for the first part (xxxx) and second part (/ yyyy)
    String formatted = '';
    if (digits.length <= 3) {
      formatted = digits; // Only the first group (xxxx)
    } else if (digits.length >= 7 && digits.length > 3) {
      // Split the first and second parts
      String yearPart = digits.substring(3);

      // Check if the year part is a valid year (1950 to current year)
      int year = int.tryParse(yearPart) ?? 0;
      if (year >= 1950 && year <= currentYear) {
        formatted = '${digits.substring(0, 3)} / $year';
      } else {
        formatted =
            '${digits.substring(0, 3)} / 1950'; // Use default valid year (1950)
      }
    } else {
      // Handle case where there are more than 8 digits
      formatted = '${digits.substring(0, 3)} / ${digits.substring(3)}';
    }

    // Ensure the cursor stays at the end of the text
    int selectionIndex = formatted.length;
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

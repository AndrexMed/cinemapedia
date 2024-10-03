import 'package:intl/intl.dart';

class HumanFormats {
  static String formatNumber(double number, [int decimals = 0]) {
    return NumberFormat.compactCurrency(
            decimalDigits: decimals, symbol: '', locale: 'en')
        .format(number);
  }

  static String shortDate(DateTime date) {
    final format = DateFormat.yMMMd('en_US');
    return format.format(date);
  }
}

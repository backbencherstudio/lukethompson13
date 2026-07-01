import 'package:intl/intl.dart';

class AppDateUtils {
  static String formatDate(String? date, {String formatter = 'MMM dd, yyyy'}) {
    if (date == null) return '';
    final dt = DateTime.tryParse(date);
    if (dt == null) return '';
    return DateFormat(formatter).format(dt);
  }

  static String formatDateWithTime(String? date) {
    return formatDate(date, formatter: 'MMM dd, yyyy hh:mm a');
  }
}

class Currency {
  static String addPrefix(String? amount, {String prefix = '\$'}) {
    return '$prefix${amount ?? "0.00"}';
  }
}

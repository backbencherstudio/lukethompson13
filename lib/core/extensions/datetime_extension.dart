import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String format({String formatter = 'MMM dd, yyyy'}) =>
      DateFormat(formatter).format(toLocal());

  String formatTime() => format(formatter: 'hh:mm a');

  String formatDateWithTime() => format(formatter: 'MMM dd, yyyy • hh:mm a');
}

extension IsoUtcParsing on String {
  DateTime? toLocalFromUtc() {
    final dt = DateTime.tryParse(this);
    return dt?.toLocal();
  }
}

class AppDateUtils {
  AppDateUtils._();

  static String formatDate(String? date, {String formatter = 'MMM dd, yyyy'}) {
    if (date == null) return '';
    final dt = DateTime.tryParse(date)?.toLocal();
    if (dt == null) return '';
    return dt.format(formatter: formatter);
  }

  static String formatTime(String? date) =>
      formatDate(date, formatter: 'hh:mm a');

  static String formatDateWithTime(String? date) =>
      formatDate(date, formatter: 'MMM dd, yyyy hh:mm a');
}

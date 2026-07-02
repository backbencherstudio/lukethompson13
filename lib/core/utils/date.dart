import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

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

class CurrencyFormatter {
  CurrencyFormatter._();

  static String format(Object? amount, {String symbol = r'$'}) {
    if (amount == null) return '${symbol}0.00';

    return switch (amount) {
      num() => '$symbol${amount.toStringAsFixed(2)}',
      String() => amount.isEmpty ? '${symbol}0.00' : '$symbol$amount',
      _ => '${symbol}0.00',
    };
  }
}

class ValueFormatter {
  ValueFormatter._();

  static String withPrefix(
    Object? value, {
    required String prefix,
    String defaultValue = '0',
  }) {
    final text = switch (value) {
      null => defaultValue,
      String(:final isEmpty) when isEmpty => defaultValue,
      _ => value.toString(),
    };

    return '$prefix$text';
  }

  static String withSuffix(
    Object? value, {
    required String suffix,
    String defaultValue = '0',
  }) {
    final text = switch (value) {
      null => defaultValue,
      String(:final isEmpty) when isEmpty => defaultValue,
      _ => value.toString(),
    };

    return '$text$suffix';
  }

  static String asPercentage(Object? value) {
    return withSuffix(value, suffix: '%');
  }
}

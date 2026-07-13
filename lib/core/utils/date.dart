import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static String format(
    Object? amount, {
    String symbol = r'$',
    int decimalDigits = 2,
  }) {
    final value = _parse(amount);

    return NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format(value);
  }

  static String compact(
    Object? amount, {
    String symbol = r'$',
    int decimalDigits = 2,
    int compactAfterDigits = 5,
  }) {
    final value = _parse(amount);

    final digits = value.abs().truncate().toString().length;

    if (digits < compactAfterDigits) {
      return NumberFormat.currency(
        symbol: symbol,
        decimalDigits: decimalDigits,
      ).format(value);
    }

    return NumberFormat.compactCurrency(
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format(value);
  }

  static String plain(Object? amount, {int decimalDigits = 2}) {
    final value = _parse(amount);

    return NumberFormat.decimalPattern().format(
      double.parse(value.toStringAsFixed(decimalDigits)),
    );
  }

  static num _parse(Object? amount) {
    return switch (amount) {
      num() => amount,
      String() => num.tryParse(amount) ?? 0,
      _ => 0,
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

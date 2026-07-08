import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/utils/logger.dart';

Future<(Object?, T?, StackTrace?)> tryAwait<T>(
  Future<T> future, {
  void Function(Object error, StackTrace stackTrace)? onError,
}) async {
  try {
    return (null, await future, null);
  } catch (e, st) {
    log.e('tryAwait failed', error: e, stackTrace: st);
    onError?.call(e, st);
    return (e, null, st);
  }
}

void showSnackbarError(BuildContext context, Object error) {
  if (context.mounted) {
    context.showErrorSnackBar(error.toString());
  }
}

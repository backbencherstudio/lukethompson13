import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/utils/logger.dart';

Future<(Object?, T?)> tryAwait<T>(
  Future<T> future, {
  void Function(Object error, StackTrace stackTrace)? onError,
}) async {
  try {
    return (null, await future);
  } catch (e, st) {
    logger.e('tryAwait failed', error: e, stackTrace: st);
    onError?.call(e, st);
    return (e, null);
  }
}

void showSnackbarError(BuildContext context, Object error) {
  if (context.mounted) {
    context.showErrorSnackBar(error.toString());
  }
}

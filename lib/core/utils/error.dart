import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';

Future<((Object, StackTrace)?, T?)> tryAwait<T>(
  Future<T> future, {
  void Function(Object error, StackTrace stackTrace)? onError,
}) async {
  try {
    return (null, await future);
  } catch (e, st) {
    onError?.call(e, st);
    return ((e, st), null);
  }
}

void showSnackbarError(BuildContext context, Object error) {
  if (context.mounted) {
    context.showErrorSnackBar(error.toString());
  }
}

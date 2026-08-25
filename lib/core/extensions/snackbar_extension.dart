import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

extension AppSnackBar on BuildContext {
  void showSnackBar({
    required String title,
    String? subtitle,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final (background, icon) = switch (type) {
      SnackBarType.success => (
        const Color(0xFF16A34A),
        Icons.check_circle_rounded,
      ),
      SnackBarType.error => (const Color(0xFFDC2626), Icons.cancel_rounded),
      SnackBarType.warning => (
        const Color(0xFFF59E0B),
        Icons.warning_amber_rounded,
      ),
      SnackBarType.info => (const Color(0xFF2563EB), Icons.info_rounded),
    };

    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          elevation: 0,
          backgroundColor: background,
          duration: duration,
          content: Container(
            decoration: BoxDecoration(
              color: background,
              boxShadow: [
                BoxShadow(
                  color: background.withValues(alpha: 0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withValues(alpha: 0.18),
                  child: Icon(icon, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  void showResultSnackBar(
    String message, {
    bool isSuccess = true,
    String? subtitle,
  }) => showSnackBar(
    title: message,
    subtitle: subtitle,
    type: isSuccess ? SnackBarType.success : SnackBarType.error,
  );

  void showSuccessSnackBar(String message, {String? subtitle}) => showSnackBar(
    title: message,
    subtitle: subtitle,
    type: SnackBarType.success,
  );

  void showErrorSnackBar(String message, {String? subtitle}) => showSnackBar(
    title: message,
    subtitle: subtitle,
    type: SnackBarType.error,
  );

  void showWarningSnackBar(String message, {String? subtitle}) => showSnackBar(
    title: message,
    subtitle: subtitle,
    type: SnackBarType.warning,
  );

  void showInfoSnackBar(String message, {String? subtitle}) =>
      showSnackBar(title: message, subtitle: subtitle, type: SnackBarType.info);
}

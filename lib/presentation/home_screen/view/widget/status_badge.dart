import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final Color? textColor;
  final Color? backgroundColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const StatusBadge({
    super.key,
    required this.status,
    this.textColor,
    this.backgroundColor,
    this.fontSize = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  factory StatusBadge.small({
    Key? key,
    required String status,
    Color? textColor,
    Color? backgroundColor,
  }) {
    return StatusBadge(
      key: key,
      status: status,
      textColor: textColor,
      backgroundColor: backgroundColor,
      fontSize: 10,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (status.trim().isEmpty) return const SizedBox.shrink();

    final color = textColor ?? StatusBadge.resolveColor(status);
    final bg = backgroundColor ?? color.withValues(alpha: 0.1);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: fontSize.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static Color resolveColor(String status) {
    switch (status.trim().toLowerCase()) {
      case 'good payer' || 'claim now' || 'paid':
        return ColorManager.successColor;

      case 'average payer' || 'rate shipper' || 'submitted':
        return ColorManager.warningColor;

      case 'poor payer' || 'denied':
        return ColorManager.errorColor;

      case 'no claim':
        return ColorManager.subtextColor;

      case 'review claim':
      default:
        return ColorManager.infoColor;
    }
  }
}

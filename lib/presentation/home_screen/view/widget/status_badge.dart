import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final Color? textColor;
  final Color? backgroundColor;

  const StatusBadge({
    super.key,
    required this.status,
    this.textColor,
    this.backgroundColor,
  });

  Color _resolveColor() {
    switch (status) {
      case 'Good Payer':
        return ColorManager.successColor;
      case 'Average Payer':
        return ColorManager.warningColor;
      case 'Poor Payer':
        return ColorManager.errorColor;
      default:
        return ColorManager.infoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (status.trim().isEmpty) return const SizedBox.shrink();

    final color = textColor ?? _resolveColor();
    final bg = backgroundColor ?? color.withValues(alpha: 0.1);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/status_colorable.dart';

class StatusBadge extends StatelessWidget {
  final StatusColorable? status;
  final Color? textColor;
  final Color? backgroundColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const StatusBadge({
    super.key,
    required this.status,
    this.textColor,
    this.backgroundColor,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  });

  factory StatusBadge.small({
    Key? key,
    required StatusColorable status,
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
    final status = this.status;
    if (status == null) return const SizedBox.shrink();

    final color = textColor ?? status.badgeColor;
    final bg = backgroundColor ?? color.withValues(alpha: 0.1);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: color,
          fontSize: fontSize.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

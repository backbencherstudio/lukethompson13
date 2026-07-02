import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/app_card.dart';

class WeeklySummaryWidget extends StatelessWidget {
  final String? title;
  final String? value;
  final String? subtitle;
  final String? icon;

  final Color? backgroundColor;
  final Color? titleColor;
  final Color? valueColor;
  final Color? subtitleColor;
  final Color? iconColor;
  final Color? borderColor;

  const WeeklySummaryWidget({
    super.key,
    this.title,
    this.value,
    this.subtitle,
    this.icon,
    this.backgroundColor,
    this.titleColor,
    this.valueColor,
    this.subtitleColor = ColorManager.subtextColor,
    this.iconColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Image.asset(
                  icon!,
                  color: iconColor ?? Colors.redAccent,
                  height: 18.h,
                  width: 18.w,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                title ?? "",
                style: TextStyle(
                  color: titleColor ?? Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value ?? "",
            style: TextStyle(
              color: valueColor ?? Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle ?? "",
            style: TextStyle(color: subtitleColor, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

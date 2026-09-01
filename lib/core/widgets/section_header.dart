import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;
  final double fontSize;
  final TextAlign? textAlign;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.fontSize = 20,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: textAlign == .center
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: fontSize.sp,
                  color: ColorManager.whiteColor,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: textAlign,
              ),
              if (subtitle != null) ...[
                SizedBox(height: 4.h),
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: ColorManager.subtextColor,
                  ),
                  textAlign: textAlign,
                ),
              ],
            ],
          ),
        ),
        ?action,
      ],
    );
  }
}

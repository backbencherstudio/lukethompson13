import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class HeadingSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const HeadingSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: ColorManager.textColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16.sp,
            color: ColorManager.subtextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

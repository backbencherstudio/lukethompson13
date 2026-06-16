import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? action;
  final double fontSize;

  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize.sp,
            color: ColorManager.whiteColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        ?action,
      ],
    );
  }
}

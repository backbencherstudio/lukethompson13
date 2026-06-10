import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class GlobalAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const GlobalAppBar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onBack ?? () => Navigator.pop(context),
          child: Image.asset(
            IconManager.arrowLeft,
            width: 26.w,
            height: 24.h,
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: ColorManager.textColor,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/svg_circle_icon.dart';

class GetPremiumIcon extends StatelessWidget {
  final String title;
  final String description;

  const GetPremiumIcon({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .center,
      children: [
        SvgCircleIcon(svgPath: Assets.icons.crownAlt),
        SizedBox(height: 4.h),

        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),

        SizedBox(height: 2.h),

        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 250.w),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorManager.subtextColor,
              fontSize: 12.sp,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

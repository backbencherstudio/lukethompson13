import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/svg_circle_icon.dart';

class GetPremiumIcon extends StatelessWidget {
  const GetPremiumIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .center,
      children: [
        SvgCircleIcon(svgPath: Assets.icons.crownAlt),
        SizedBox(height: 12.h),
        // Title
        Text(
          'Get Premium',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),

        SizedBox(height: 4.h),

        Text(
          'Unlock premium features',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorManager.subtextColor,
            fontSize: 16.sp,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

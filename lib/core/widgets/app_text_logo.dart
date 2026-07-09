import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class AppTextLogo extends StatelessWidget {
  const AppTextLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "GET",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "DOCK",
            style: TextStyle(
              color: ColorManager.primaryButton,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "PAY",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

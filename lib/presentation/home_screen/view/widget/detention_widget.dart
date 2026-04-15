import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class DetentionWidget extends StatelessWidget {
  final String? title;
  final String? price;
  final String? rate;
  final String? imagePath;
  final Color? titleColor;
  final Color? priceColor;
  final Color? rateColor;

  const DetentionWidget({
    super.key,
    this.title,
    this.price,
    this.rate,
    this.imagePath,
    this.titleColor,
    this.priceColor,
    this.rateColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          width: 1,
          color: ColorManager.backgroundColorgreen1.withValues(alpha: .2),
        ),
        color: ColorManager.boxColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, 
          children: [
            Row(
              children: [
                
                if (imagePath != null && imagePath!.isNotEmpty) ...[
                  Image.asset(imagePath!, width: 20.w, height: 20.h),
                  SizedBox(width: 8.w),
                ],
                Text(
                  title ?? "Detention Widget", 
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: titleColor ?? ColorManager.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              price ?? "\$0",
              style: TextStyle(
                fontSize: 32.sp,
                color: priceColor ?? ColorManager.primaryButton, 
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              rate ?? "\$0/hr rate", 
              style: TextStyle(
                color: rateColor ?? ColorManager.greyText, 
                fontSize: 12.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
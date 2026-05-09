import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/unlock_dialog.dart';

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
    return GestureDetector(
      onTap: () async {
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => const UnlockDialog(),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            width: 1,
            color: ColorManager.backgroundColorgreen1.withValues(alpha: .2),
          ),
          color: ColorManager.boxColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header: Icon + Title
              Row(
                children: [
                  if (imagePath != null && imagePath!.isNotEmpty) ...[
                    Image.asset(
                      imagePath!, 
                      width: 20.w, 
                      height: 20.h,
                      // errorBuilder ব্যবহার করা ভালো যদি ইমেজ না পাওয়া যায়
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 20.sp, color: Colors.red),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Expanded(
                    child: Text(
                      title ?? "Detention",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: titleColor ?? ColorManager.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20.h),

              // Price Text
              Text(
                price ?? "\$0",
                style: TextStyle(
                  fontSize: 32.sp,
                  color: priceColor ?? ColorManager.primaryButton,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 2.h),

              // Rate Text
              Text(
                rate ?? "\$0/hr rate",
                style: TextStyle(
                  color: rateColor ?? ColorManager.greyText,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
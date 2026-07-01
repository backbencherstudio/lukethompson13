import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/unlock_dialog.dart';

class DetentionData {
  final String? imagePath;
  final String? title;
  final String? value;
  final String? subtitle;
  final Color? titleColor;
  final Color? valueColor;
  final Color? subtitleColor;

  const DetentionData({
    this.imagePath,
    this.title,
    this.value,
    this.subtitle,
    this.titleColor,
    this.valueColor,
    this.subtitleColor,
  });
}

class DetentionWidget extends StatelessWidget {
  final DetentionData data;

  const DetentionWidget({super.key, required this.data});

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
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            width: 1,
            color: ColorManager.backgroundColorgreen1.withValues(alpha: .2),
          ),
          color: ColorManager.boxColor,
        ),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .spaceBetween,
          children: [
            Row(
              children: [
                if (data.imagePath != null && data.imagePath!.isNotEmpty) ...[
                  Image.asset(
                    data.imagePath!,
                    width: 20.w,
                    height: 20.h,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error, size: 20.sp, color: Colors.red),
                  ),
                  SizedBox(width: 8.w),
                ],
                Expanded(
                  child: Text(
                    data.title ?? "Detention",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: data.titleColor ?? ColorManager.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  data.value ?? "\$0",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: data.valueColor ?? ColorManager.primaryButton,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  data.subtitle ?? "",
                  style: TextStyle(
                    color: data.subtitleColor ?? ColorManager.greyText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

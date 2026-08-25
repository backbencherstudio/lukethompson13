import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    this.iconPath,
    required this.title,
    required this.subtitle,
    this.bottomWidget,
    this.iconWidth,
    this.iconHeight,
  });

  final String? iconPath;
  final String title;
  final String subtitle;
  final Widget? bottomWidget;
  final double? iconWidth;
  final double? iconHeight;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.surfaceBacground,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // if (iconPath != null) ...[
            //   AppSvgIcon(iconPath!, width: iconWidth, height: iconHeight),
            //   20.verticalSpace,
            // ],
            Text(
              title,
              style: context.titleLarge.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            8.verticalSpace,

            Text(
              subtitle,
              style: context.bodyMedium.copyWith(
                color: ColorManager.subtextColor,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            if (bottomWidget != null) ...[20.verticalSpace, bottomWidget!],
          ],
        ),
      ),
    );
  }
}

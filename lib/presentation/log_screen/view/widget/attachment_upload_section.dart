import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/global_button.dart';

class AttachmentUploadSection extends StatelessWidget {
  const AttachmentUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Attachments", style: context.labelLarge),
        SizedBox(height: 12.h),
        DottedBorder(
          color: ColorManager.subtextColor.withValues(alpha: 0.5),
          strokeWidth: 1.5,
          dashPattern: const [6, 4],
          borderType: BorderType.RRect,
          radius: Radius.circular(15.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            decoration: BoxDecoration(
              color: const Color(0xFF111821),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              children: [
                Container(
                  height: 45.w,
                  width: 45.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F2623),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cloud_upload,
                    color: ColorManager.primaryButton,
                    size: 24,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Tap to upload photo",
                  style: TextStyle(
                    color: ColorManager.primaryButton,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "PNG, JPG or PDF (max. 800x400px)",
                  style: TextStyle(
                    color: const Color(0xFF6C757D),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: ColorManager.subtextColor.withValues(alpha: 0.5),
                        indent: 40.w,
                        endIndent: 10.w,
                      ),
                    ),
                    Text(
                      "or",
                      style: TextStyle(
                        color: ColorManager.subtextColor.withValues(alpha: 0.5),
                        fontSize: 14.sp,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: ColorManager.subtextColor.withValues(alpha: 0.5),
                        indent: 10.w,
                        endIndent: 40.w,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                GlobalButton.primaryOutlined(
                  foregroundColor: ColorManager.primaryButton,
                  width: 160,
                  fontSize: 14,
                  label: 'Open Camera',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

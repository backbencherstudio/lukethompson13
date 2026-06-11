import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/global_button.dart';

class UnlockDialog extends StatelessWidget {
  final String title;
  final String description;
  final String subscribeLabel;
  final String trialLabel;
  final VoidCallback? onSubscribe;
  final VoidCallback? onContinueTrial;

  const UnlockDialog({
    super.key,
    this.title = "Unlock Your Full\nDriver Log",
    this.description =
        "Get unlimited stop logging, instant PDF exports, advanced detention analytics, and an ad-free experience.",
    this.subscribeLabel = "Subscribe Now",
    this.trialLabel = "Continue with Free Trial",
    this.onSubscribe,
    this.onContinueTrial,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1F22).withOpacity(0.75),
            borderRadius: BorderRadius.circular(28.r),

            border: Border.all(
              color: Colors.white.withOpacity(0.12),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),

              _buildLockIcon(),

              SizedBox(height: 28.h),

              // Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),

              SizedBox(height: 12.h),

              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorManager.subtextColor,
                  fontSize: 16.sp,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 32.h),

              GlobalButton(label: subscribeLabel, onPressed: onSubscribe ?? () {}),

              SizedBox(height: 8.h),

              TextButton(
                onPressed: onContinueTrial ?? () => Navigator.pop(context),
                child: Text(
                  trialLabel,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  Stack _buildLockIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 90.w,
          width: 90.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2ECC71).withOpacity(0.4),
                blurRadius: 40,
                spreadRadius: 5,
              ),
            ],
          ),
        ),
        Container(
          height: 85.w,
          width: 85.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.05),
            border: Border.all(color: Colors.white10, width: 2),
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock,
                color: const Color(0xFF2ECC71),
                size: 32.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/widgets/global_button.dart';

class UnlockDialog extends StatelessWidget {
  const UnlockDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
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

              Stack(
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
                  // আইকন কন্টেইনার
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
              ),

              SizedBox(height: 30.h),

              // Title
              Text(
                "Unlock Your Full\nDriver Log",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),

              SizedBox(height: 16.h),

              Text(
                "Get unlimited stop logging, instant PDF exports, advanced detention analytics, and an ad-free experience.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0XFF8DA2B8),
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 32.h),

              GlobalButton(label: "Subscribe Now", onPressed: () {}),

              SizedBox(height: 20.h),

              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  "Continue with Free Trial",
                  style: TextStyle(
                    color: const Color(0xFF2ECC71),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xFF2ECC71),
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
}


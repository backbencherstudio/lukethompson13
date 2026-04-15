import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';

class OnboardingScreen2 extends StatelessWidget {
  final String? waitTime;
  final String? bilableRate;

  const OnboardingScreen2({super.key, this.waitTime, this.bilableRate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [ColorManager.secondary, ColorManager.primary],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                SizedBox(height: 18.h),
                Center(
                  child: Image.asset(
                    IconManager.onboardingScreen,
                    height: 210.h,
                    width: 210.w,
                  ),
                ),
                SizedBox(height: 12.h),
                Center(
                  child: Text(
                    "You’re All Set!",
                    style: TextStyle(
                      color: ColorManager.textColor,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Center(
                  child: Text(
                    "See how much you can recover",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorManager.subtextColor,
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: ColorManager.whiteColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: ColorManager.whiteColor.withValues(alpha: 0.22),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "At a 5-hour detention:",
                        style: TextStyle(
                          color: ColorManager.textColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "\$225.00",
                        style: TextStyle(
                          color: const Color(0xFFFF6C63),
                          fontSize: 34.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "You could recover",
                        style: TextStyle(
                          color: ColorManager.subtextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Divider(
                        color: ColorManager.whiteColor.withValues(alpha: 0.18),
                        height: 1,
                      ),
                      SizedBox(height: 14.h),
                      const _SummaryRow(label: "Hourly Rate:", value: "\$50/hr"),
                      SizedBox(height: 12.h),
                      _SummaryRow(
                        label: "Free Wait Time:",
                        value: "${(waitTime?.isNotEmpty ?? false) ? waitTime : "2"}h",
                      ),
                      SizedBox(height: 12.h),
                      _SummaryRow(
                        label: "Billable Rate:",
                        value:
                            "${(bilableRate?.isNotEmpty ?? false) ? bilableRate : "\$50"}/hr",
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _BottomIndicator(isActive: false),
                      SizedBox(width: 8.w),
                      _BottomIndicator(isActive: true),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 54.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.singupScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF39D77A),
                      foregroundColor: ColorManager.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _BottomIndicator extends StatelessWidget {
  final bool isActive;

  const _BottomIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isActive ? 22.w : 6.w,
      height: 6.h,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF39D77A)
            : ColorManager.whiteColor.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20.r),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: ColorManager.subtextColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: ColorManager.textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

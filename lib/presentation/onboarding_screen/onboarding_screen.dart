import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/onboarding_screen/onboarding_screen2.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  final TextEditingController waitTimeController = TextEditingController();
  final TextEditingController billableRateController = TextEditingController();

  @override
  void dispose() {
    waitTimeController.dispose();
    billableRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppGradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36.h),
                Center(
                  child: Text(
                    "Set Your Hourly Rate",
                    style: TextStyle(
                      color: ColorManager.textColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Center(
                  child: Text(
                    "How much do you earn per hour?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorManager.subtextColor,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  "Free Wait Time (Hours)",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: ColorManager.textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomTextFieldWidget(
                  hintText: "2",
                  controller: waitTimeController,
                ),
                SizedBox(height: 24.h),
                Text(
                  "Rate After Free Time (\$/hr)",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: ColorManager.textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomTextFieldWidget(
                  hintText: "\$50",
                  controller: billableRateController,
                ),
                const Spacer(),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _BottomIndicator(isActive: true),
                      SizedBox(width: 8.w),
                      _BottomIndicator(isActive: false),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                GlobalButton(
                  label: "Next",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => OnboardingScreen2(
                          waitTime: waitTimeController.text.trim(),
                          bilableRate: billableRateController.text.trim(),
                        ),
                      ),
                    );
                  },
                ),
                16.height,
                GlobalButton.secondary(
                  label: "Skip",
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.singupScreen);
                  },
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

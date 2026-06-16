import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/gen/assets.gen.dart';

class ReviewSubmitted extends StatelessWidget {
  const ReviewSubmitted({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GlobalAppBar(title: 'Back'),
        body: SafeArea(
          child: FullHeightScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              children: [
                SizedBox(height: 16.h),

                // Success Icon with glow effect
                Center(child: Assets.icons.submittedIcon.image(height: 80.w)),
                SizedBox(height: 35.h),

                // Text section
                Text(
                  "Review Submitted!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  "Thanks for helping the community. Your rating\nhas been recorded.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorManager.subtextColor,
                    fontSize: 15.sp,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 40.h),

                // Information Box
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 25.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.primaryButton.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                      color: ColorManager.primaryButton,
                      width: 1,
                    ),
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(text: "Your anonymous report helps "),
                        TextSpan(
                          text: "other drivers ",
                          style: TextStyle(
                            color: ColorManager.primaryButton,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                              "make smarter decisions before accepting loads at this facility.",
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // Back to Home Button
                GlobalButton(
                  label: "Back to Home",
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RoutesName.parentScreen,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

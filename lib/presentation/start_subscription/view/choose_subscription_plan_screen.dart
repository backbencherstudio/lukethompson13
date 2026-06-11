import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/svg_circle_icon.dart';

const _monthlyFeatures = [
  'Unlimited stop logging',
  'Invoice Export & Send',
  'Advanced analytics',
  'Debt Collection & Legal Services',
  'Ad-free experience',
];

const _yearlyFeatures = [
  'Unlimited stop logging',
  'Invoice Export & Send',
  'Advanced analytics',
  'Debt Collection & Legal Services',
  'Ad-free experience',
];

class ChooseSubscriptionPlanScreen extends StatelessWidget {
  const ChooseSubscriptionPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GlobalAppBar(title: 'Back'),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GetPremiumIcon(),
              24.height,
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    width: 1,
                    color: Colors.white.withValues(alpha: .15),
                  ),
                  color: ColorManager.boxColor,
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    ...List.generate(
                      _monthlyFeatures.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(top: index == 0 ? 0 : 12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outlined,
                              color: ColorManager.primaryButton,
                            ),
                            8.width,
                            Text(
                              _monthlyFeatures[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: .w700,
                                letterSpacing: 0.2,
                                color: ColorManager.subtextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              32.height,
              Center(
                child: SizedBox.square(
                  dimension: 64.w,
                  child: Assets.icons.appLogo.image(),
                ),
              ),
              12.height,
              Center(
                child: Text(
                  'Choose your plan',
                  textAlign: .center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: .w700,
                    color: Colors.white,
                  ),
                ),
              ),
              16.height,
              Container(
                padding: .all(12.w),
                decoration: BoxDecoration(
                  color: Color(0xff111926),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    PlanCard(
                      isSelected: false,
                      title: 'Pro Monthly',
                      duration: 'month',
                      planType: 'Standard',
                      price: '\$12.99',
                    ),
                    12.width,
                    PlanCard(
                      isSelected: false,
                      title: 'Pro Yearly',
                      titleColor: ColorManager.warningColor,
                      duration: 'year',
                      planType: 'Premium',
                      price: '\$99.00',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.title,
    required this.duration,
    required this.planType,
    required this.price,
    this.titleColor = ColorManager.primaryButton,
    required this.isSelected,
    this.onTap,
  });

  final String title;
  final String duration;
  final String planType;
  final String price;
  final Color titleColor;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.4,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: .all(12.w),
            foregroundDecoration: BoxDecoration(
              border: Border.all(color: ColorManager.primaryButton, width: 2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            decoration: BoxDecoration(
              color: Color(0xff0A0F1A),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 14.sp,
                        fontWeight: .w700,
                      ),
                    ),
                    4.height,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: price,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: .w700,
                            ),
                          ),
                          TextSpan(
                            text: '/$duration',
                            style: TextStyle(
                              color: ColorManager.subtextColor,
                              fontSize: 14,
                              fontWeight: .w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(planType, style: TextStyle(color: Colors.white)),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.check_circle_outlined,
                    color: ColorManager.primaryButton,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GetPremiumIcon extends StatelessWidget {
  const GetPremiumIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .center,
      children: [
        SvgCircleIcon(svgPath: Assets.icons.crownAlt),
        SizedBox(height: 12.h),
        // Title
        Text(
          'Get Premium',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),

        SizedBox(height: 4.h),

        Text(
          'Unlock premium features',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorManager.subtextColor,
            fontSize: 16.sp,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

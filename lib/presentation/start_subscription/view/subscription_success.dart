import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/font_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/section_header.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/start_subscription/state/choose_subscription_plan_state.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/get_premium_icon.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/payment_option.dart';

class SubscriptionSuccess extends StatefulWidget {
  const SubscriptionSuccess({super.key, this.isFree = false});

  final bool isFree;

  @override
  State<SubscriptionSuccess> createState() => _SubscriptionSuccessState();
}

class _SubscriptionSuccessState extends State<SubscriptionSuccess> {
  @override
  Widget build(BuildContext context) {
    return AppGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GlobalAppBar(hideBackButton: true),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Assets.images.subscriptionSuccess.image(),
                ),
                16.height,
                Text(
                  widget.isFree
                      ? 'Your Free Trial is \nSuccessful'
                      : 'Your subscription is \nSuccessful',
                  style: context.headlineLarge.copyWith(fontSize: FontSize.s28),
                  textAlign: .center,
                ),
                8.height,
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: context.bodyLarge.copyWith(
                      color: ColorManager.subtextColor,
                      fontSize: 16,
                      height: 1.5,
                    ),
                    children: widget.isFree
                        ? [
                            const TextSpan(
                              text:
                                  'Congratulations! Your Free Trial has been successfully updated. Now enjoy 5 free stop logs. Subscribe to continue with unlimited stop logging, PDF export, and advanced analytics.',
                            ),
                          ]
                        : [
                            const TextSpan(
                              text: 'Thank you for your subscription to\n',
                            ),
                            const TextSpan(
                              text: 'GET',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: 'DOCK',
                              style: TextStyle(
                                color: ColorManager.primaryButton, // green
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: 'PAY',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  ', enjoy various premium\nfeatures with unlimited stop logging, PDF\nexport, and advanced analytics.',
                            ),
                          ],
                  ),
                ),

                const Spacer(),

                GlobalButton(
                  label: "Back to Home",
                  onPressed: () {
                    context.go(Routes.parent);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}

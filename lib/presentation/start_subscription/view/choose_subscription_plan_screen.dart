import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/start_subscription/state/choose_subscription_plan_state.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/feature_list_card.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/get_premium_icon.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/plan_card.dart';

class ChooseSubscriptionPlanScreen extends ConsumerStatefulWidget {
  const ChooseSubscriptionPlanScreen({super.key});

  @override
  ConsumerState<ChooseSubscriptionPlanScreen> createState() =>
      _ChooseSubscriptionPlanScreenState();
}

class _ChooseSubscriptionPlanScreenState
    extends ConsumerState<ChooseSubscriptionPlanScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedPlanId = ref.watch(selectedPlanIdProvider).selectedPlanId;

    return AppGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GlobalAppBar(title: 'Back'),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                12.height,
                GetPremiumIcon(),
                24.height,
                FeatureListCard(features: getFeaturedPlanItems(selectedPlanId)),
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
                _buildCardsRow(selectedPlanId),

                16.height,
                GlobalButton(
                  label: "Subscribe Now",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.chooseSubscriptionPaymentMethod,
                    );
                  },
                ),
                16.height,
                GlobalButton.secondary(
                  label: "Start Free Trial",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.subscriptionSuccessful,
                      arguments: {'isFree': true},
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

  Container _buildCardsRow(String selectedPlanId) {
    return Container(
      padding: .all(12.w),
      decoration: BoxDecoration(
        color: Color(0xff111926),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          PlanCard(
            isSelected: selectedPlanId == planIdMonthly,
            title: 'Pro Monthly',
            duration: 'month',
            planType: 'Standard',
            price: '\$12.99',
            onTap: () => ref
                .read(selectedPlanIdProvider.notifier)
                .selectPlan(planIdMonthly),
          ),
          12.width,
          PlanCard(
            isSelected: selectedPlanId == planIdYearly,
            title: 'Pro Yearly',
            titleColor: ColorManager.warningColor,
            duration: 'year',
            planType: 'Premium',
            price: '\$99.00',
            onTap: () => ref
                .read(selectedPlanIdProvider.notifier)
                .selectPlan(planIdYearly),
          ),
        ],
      ),
    );
  }
}

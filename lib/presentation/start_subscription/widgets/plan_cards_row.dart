import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/config.dart';
import 'package:lukethompson/core/services/revenuecat_providers.dart';
import 'package:lukethompson/core/widgets/shimmer_loading.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/plan_card.dart';

class PlanCardsRow extends ConsumerWidget {
  final String selectedPlanId;
  final AsyncValue<SubscriptionPackages> packagesAsync;
  final String monthlyPrice;
  final String yearlyPrice;
  final ValueChanged<String> onSelectPlan;

  const PlanCardsRow({
    super.key,
    required this.selectedPlanId,
    required this.packagesAsync,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.onSelectPlan,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: .all(12.w),
      decoration: BoxDecoration(
        color: ColorManager.surfaceBacground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: packagesAsync.isLoading
          ? Row(
              children: [
                Expanded(
                  child: ShimmerBox(height: 150.w, borderRadius: 12.r),
                ),
                12.width,
                Expanded(
                  child: ShimmerBox(height: 150.w, borderRadius: 12.r),
                ),
              ],
            )
          : packagesAsync.hasError
          ? Column(
              children: [
                Text(
                  'Could not load prices. Check your connection and retry.',
                  textAlign: .center,
                  style: TextStyle(
                    color: ColorManager.subtextColor,
                    fontSize: 14.sp,
                  ),
                ),
                8.height,
                TextButton(
                  onPressed: () => ref.invalidate(offeringPackagesProvider),
                  child: const Text('Retry'),
                ),
              ],
            )
          : Row(
              children: [
                PlanCard(
                  isSelected:
                      selectedPlanId == AppConfig.revenueCatProMonthlyPackageId,
                  title: 'Pro Monthly',
                  duration: 'month',
                  planType: 'Standard',
                  price: monthlyPrice,
                  onTap: () =>
                      onSelectPlan(AppConfig.revenueCatProMonthlyPackageId),
                ),
                12.width,
                PlanCard(
                  isSelected:
                      selectedPlanId == AppConfig.revenueCatProYearlyPackageId,
                  title: 'Pro Yearly',
                  titleColor: ColorManager.warningColor,
                  duration: 'year',
                  planType: 'Premium',
                  price: yearlyPrice,
                  onTap: () =>
                      onSelectPlan(AppConfig.revenueCatProYearlyPackageId),
                ),
              ],
            ),
    );
  }
}

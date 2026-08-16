import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/config.dart';
import 'package:lukethompson/core/resource/utils.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/services/revenuecat_providers.dart';
import 'package:lukethompson/core/services/revenuecat_service.dart';
import 'package:lukethompson/core/utils/logger.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/global_tab_bar.dart';
import 'package:lukethompson/core/widgets/shimmer_loading.dart';
import 'package:lukethompson/presentation/start_subscription/state/choose_subscription_plan_state.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/feature_list_card.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/get_premium_icon.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/plan_card.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class ChooseSubscriptionPlanScreen extends ConsumerStatefulWidget {
  const ChooseSubscriptionPlanScreen({super.key});

  @override
  ConsumerState<ChooseSubscriptionPlanScreen> createState() =>
      _ChooseSubscriptionPlanScreenState();
}

class _ChooseSubscriptionPlanScreenState
    extends ConsumerState<ChooseSubscriptionPlanScreen>
    with SingleTickerProviderStateMixin {
  var isProTab = true;
  late final TabController _tabController = TabController(
    length: 2,
    vsync: this,
  );

  bool _isSubscribing = false;
  bool _isRestoring = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabTap(int index) {
    setState(() {
      isProTab = index == 0;
    });
  }

  void _selectPlan(String planId) {
    ref.read(selectedPlanIdProvider.notifier).selectPlan(planId);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(selectedPlanIdProvider);
    final packagesAsync = ref.watch(offeringPackagesProvider);
    final packages = packagesAsync.value;

    final monthlyPrice = packages?.monthly.storeProduct.priceString ?? '';
    final yearlyPrice = packages?.yearly.storeProduct.priceString ?? '';
    final canPurchase = packages != null && !_isSubscribing;

    if (packagesAsync.hasError) {
      logger.e(packagesAsync.error.toString());
    }

    return AppGradientBackground(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: GlobalAppBar(title: 'Back'),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                12.height,
                GetPremiumIcon(
                  title: isProTab ? 'Get Pro' : 'Get Premium',
                  description: isProTab
                      ? 'Get the tools you need to document claims, follow up, and get paid.'
                      : 'Go beyond claims with advanced recovery, reporting, and legal support.',
                ),
                12.height,
                GlobalTabBar(
                  isEnabled: false,
                  controller: _tabController,
                  onTap: _onTabTap,
                  tabs: [
                    Tab(text: 'Pro'),
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Premium'),
                          SizedBox(height: 2.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'Coming soon',
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.subtextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                12.height,

                FeatureListCard(
                  features: RevenueCatService.getFeaturedPlanItems(
                    state.selectedPlanId,
                  ),
                ),
                // 32.height,
                // Center(
                //   child: SizedBox.square(
                //     dimension: 64.w,
                //     child: Assets.icons.appLogo.image(),
                //   ),
                // ),
                12.height,
                Center(
                  child: Text(
                    'Choose your plan',
                    textAlign: .center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: .w700,
                      color: Colors.white,
                    ),
                  ),
                ),

                12.height,
                _buildCardsRow(
                  selectedPlanId: state.selectedPlanId,
                  packagesAsync: packagesAsync,
                  monthlyPrice: monthlyPrice,
                  yearlyPrice: yearlyPrice,
                ),

                16.height,
                GlobalButton(
                  label: "Subscribe Now",
                  isLoading: _isSubscribing,
                  isDisabled: !canPurchase,
                  onPressed: () {
                    _purchase(_selectedPackage(packages), isTrial: false);
                  },
                ),
                16.height,
                GlobalButton.outlined(
                  label: "Start Free Trial",
                  isLoading: _isSubscribing,
                  isDisabled: !canPurchase,
                  onPressed: () {
                    _purchase(_selectedPackage(packages), isTrial: true);
                  },
                ),
                12.height,
                Center(
                  child: TextButton(
                    onPressed: _isRestoring ? null : _restorePurchases,
                    child: Text(
                      _isRestoring ? 'Restoring...' : 'Restore Purchases',
                      style: TextStyle(
                        color: ColorManager.subtextColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Package? _selectedPackage(SubscriptionPackages? packages) {
    if (packages == null) return null;
    return ref.read(selectedPlanIdProvider).selectedPlanId ==
            AppConfig.revenueCatYearlyPackageId
        ? packages.yearly
        : packages.monthly;
  }

  Widget _buildCardsRow({
    required String selectedPlanId,
    required AsyncValue<SubscriptionPackages> packagesAsync,
    required String monthlyPrice,
    required String yearlyPrice,
  }) {
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
                      selectedPlanId == AppConfig.revenueCatMonthlyPackageId,
                  title: 'Pro Monthly',
                  duration: 'month',
                  planType: 'Standard',
                  price: monthlyPrice,
                  onTap: () =>
                      _selectPlan(AppConfig.revenueCatMonthlyPackageId),
                ),
                12.width,
                PlanCard(
                  isSelected:
                      selectedPlanId == AppConfig.revenueCatYearlyPackageId,
                  title: 'Pro Yearly',
                  titleColor: ColorManager.warningColor,
                  duration: 'year',
                  planType: 'Premium',
                  price: yearlyPrice,
                  onTap: () => _selectPlan(AppConfig.revenueCatYearlyPackageId),
                ),
              ],
            ),
    );
  }

  Future<void> _purchase(Package? package, {required bool isTrial}) async {
    if (package == null) return;
    final service = ref.read(revenueCatServiceProvider);

    try {
      setState(() => _isSubscribing = true);
      final result = await service.purchase(package);
      if (!mounted) return;
      setState(() => _isSubscribing = false);

      if (service.isEntitled(result.customerInfo)) {
        context.push(Routes.subscriptionSuccess, extra: {'isFree': isTrial});
      } else {
        Utils.showErrorToast(
          message: 'Subscription not active yet. Please try again.',
        );
      }
    } on PlatformException catch (error) {
      if (!mounted) return;
      setState(() => _isSubscribing = false);
      if (!service.isPurchaseCancelled(error)) {
        Utils.showErrorToast(
          message: 'Something went wrong. Please try again.',
        );
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _isSubscribing = false);
      Utils.showErrorToast(message: 'Something went wrong. Please try again.');
    }
  }

  Future<void> _restorePurchases() async {
    final service = ref.read(revenueCatServiceProvider);
    try {
      setState(() => _isRestoring = true);
      final customerInfo = await service.restorePurchases();
      if (!mounted) return;
      setState(() => _isRestoring = false);
      Utils.showSuccessToast(
        message: service.isEntitled(customerInfo)
            ? 'Purchases restored successfully'
            : 'No purchases found to restore',
      );
    } catch (error) {
      if (!mounted) return;
      setState(() => _isRestoring = false);
      Utils.showErrorToast(
        message: 'Something went wrong restoring purchases.',
      );
    }
  }
}

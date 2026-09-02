import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/config.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/resource/utils.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/services/revenuecat_providers.dart';
import 'package:lukethompson/core/services/revenuecat_service.dart';
import 'package:lukethompson/core/utils/logger.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/global_tab_bar.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/start_subscription/state/choose_subscription_plan_state.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/feature_list_card.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/get_premium_icon.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/plan_cards_row.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

enum _PurchaseAction { subscribe, trial }

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

  bool _isRestoring = false;
  _PurchaseAction? _purchaseAction;

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
    if (!AppConfig.isRevenueCatEnabled) {
      return AppGradientBackground(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: GlobalAppBar(
            backButtonIcon: const Icon(
              Icons.close,
              size: 24,
              color: ColorManager.subtextColor,
            ),
            backButtonBackgroundColor: Colors.transparent,
          ),
          body: SafeArea(
            child: Center(
              child: StatusDisplay.muted(
                'Subscriptions are not available right now',
              ),
            ),
          ),
        ),
      );
    }

    final state = ref.watch(selectedPlanIdProvider);
    final packagesAsync = ref.watch(offeringPackagesProvider);
    final packages = packagesAsync.value;

    final monthlyPrice = packages?.monthly.storeProduct.priceString ?? '';
    final yearlyPrice = packages?.yearly.storeProduct.priceString ?? '';
    // final monthlyPrice = '19.99';
    // final yearlyPrice = '179.00';
    final canPurchase = packages != null && _purchaseAction == null;

    if (packagesAsync.hasError) {
      logger.e(packagesAsync.error.toString());
    }

    final bottomPaddingInset = Utils.bottomPaddingInset(context);

    return AppGradientBackground(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: GlobalAppBar(
          backButtonIcon: const Icon(
            Icons.close,
            size: 24,
            color: ColorManager.subtextColor,
          ),
          backButtonBackgroundColor: Colors.transparent,
          // title: 'Back',
          actions: [
            TextButton(
              onPressed: _isRestoring ? null : _restorePurchases,
              child: Text(
                _isRestoring ? '.......' : 'Restore',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorManager.subtextColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            4.width,
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: AppPadding.screenPadding,
              right: AppPadding.screenPadding,
              bottom: bottomPaddingInset,
            ),
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
                Text(
                  'Choose your plan',
                  textAlign: .center,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: .w700,
                    color: Colors.white,
                  ),
                ),

                12.height,
                PlanCardsRow(
                  selectedPlanId: state.selectedPlanId,
                  packagesAsync: packagesAsync,
                  monthlyPrice: '19.99',
                  yearlyPrice: '179.00',
                  onSelectPlan: _selectPlan,
                ),

                16.height,
                GlobalButton(
                  label: "Subscribe Now",
                  isLoading: _purchaseAction == _PurchaseAction.subscribe,
                  isDisabled: !canPurchase,
                  onPressed: () {
                    _purchase(_selectedPackage(packages), isTrial: false);
                  },
                ),
                16.height,
                GlobalButton.outlined(
                  label: "Start Free Trial",
                  isLoading: _purchaseAction == _PurchaseAction.trial,
                  isDisabled: !canPurchase,
                  onPressed: () {
                    _purchase(_selectedPackage(packages), isTrial: true);
                  },
                ),
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
            AppConfig.revenueCatProYearlyPackageId
        ? packages.yearly
        : packages.monthly;
  }

  Future<void> _purchase(Package? package, {required bool isTrial}) async {
    if (package == null) return;
    final service = ref.read(revenueCatServiceProvider);

    try {
      setState(
        () => _purchaseAction = isTrial
            ? _PurchaseAction.trial
            : _PurchaseAction.subscribe,
      );
      final result = await service.purchase(package);
      if (!mounted) return;
      setState(() => _purchaseAction = null);

      if (service.isEntitled(result.customerInfo)) {
        context.push(Routes.subscriptionSuccess, extra: {'isFree': isTrial});
      } else {
        Utils.showErrorToast(
          message: 'Subscription not active yet. Please try again.',
        );
      }
    } on PlatformException catch (error) {
      if (!mounted) return;
      setState(() => _purchaseAction = null);
      if (!service.isPurchaseCancelled(error)) {
        Utils.showErrorToast(
          message: 'Something went wrong. Please try again.',
        );
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _purchaseAction = null);
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

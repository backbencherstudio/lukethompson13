import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/config.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/resource/utils.dart';
import 'package:lukethompson/core/services/revenuecat_providers.dart';
import 'package:lukethompson/core/services/revenuecat_service.dart';
import 'package:lukethompson/core/utils/date.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/app_switch.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/profile/view/widget/subscription_info_card.dart';
import 'package:lukethompson/presentation/start_subscription/widgets/feature_list_card.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ManageSubscriptionScreen extends ConsumerWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!AppConfig.isRevenueCatEnabled) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GlobalAppBar(title: 'Manage Subscription'),
        body: AppGradientBackground(
          child: SafeArea(
            child: Center(
              child: StatusDisplay.muted(
                'Subscription management is not available on Android.',
              ),
            ),
          ),
        ),
      );
    }

    final customerInfoAsync = ref.watch(customerInfoProvider);
    final isProSubscription = ref.watch(isProSubscriptionProvider);
    final isFoundingMember = ref.watch(isFoundingMemberProvider);
    final offeringsAsync = ref.watch(offeringPackagesProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: GlobalAppBar(title: 'Manage Subscription'),
      body: AppGradientBackground(
        child: SafeArea(
          minimum: EdgeInsets.only(bottom: 12),
          child: customerInfoAsync.when(
            skipLoadingOnRefresh: true,
            loading: () => const Center(child: ActivityIndicator()),
            error: (error, _) => Center(
              child: TextButton(
                onPressed: () => ref.invalidate(customerInfoProvider),
                child: const Text('Failed to load. Tap to retry'),
              ),
            ),
            data: (customerInfo) => FullHeightScrollView(
              padding: .symmetric(horizontal: AppPadding.screenPadding),
              child: Column(
                crossAxisAlignment: .stretch,
                children: isProSubscription
                    ? _premiumContent(
                        context,
                        ref,
                        customerInfo,
                        offeringsAsync,
                      )
                    : isFoundingMember
                    ? _foundingMemberContent(context, ref)
                    : _freeContent(context, ref),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _foundingMemberContent(BuildContext context, WidgetRef ref) {
    return [
      24.height,
      SubscriptionInfoCard.subscriptionType(
        titileLeading: SvgPicture.asset(
          Assets.icons.checkBadge,
          colorFilter: ColorFilter.mode(
            ColorManager.primaryButton,
            BlendMode.srcIn,
          ),
          width: 24,
          height: 24,
        ),
        title: 'GetDockPay Pro - Founding Member',
        subtitle:
            'Enjoy all Pro features for life with your exclusive Founding Member access.',
      ),
      16.height,

      SubscriptionInfoCard.featureList(
        titileLeading: Icon(
          Icons.verified,
          color: ColorManager.whiteColor,
          size: 20,
        ),
        title: 'What You Get with Pro:',
        items: monthlyProFeatures,
      ),
      16.height,
      Spacer(),
      GlobalButton(
        label: 'Subscribe Now',
        onPressed: () => RevenueCatService.showPayWall(context),
      ),
      16.height,
      _restoreButton(ref),
    ];
  }

  List<Widget> _freeContent(BuildContext context, WidgetRef ref) {
    return [
      24.height,
      SubscriptionInfoCard.subscriptionType(
        title: 'Free Trial',
        subtitle:
            'You are on the free plan. Subscribe to unlock unlimited '
            'stop logging, PDF export, and advanced analytics.',
      ),
      16.height,
      // SubscriptionInfoCard.memberShipType(
      //   title: 'Member Type',
      //   subtitle: 'Free Trial',
      //   logsRemaining: ,
      // ),

      SubscriptionInfoCard.featureList(
        titileLeading: Icon(
          Icons.verified,
          color: ColorManager.whiteColor,
          size: 20,
        ),
        title: 'What You Get with Pro:',
        items: monthlyProFeatures,
      ),
      16.height,
      Spacer(),
      GlobalButton(
        label: 'Subscribe Now',
        onPressed: () => RevenueCatService.showPayWall(context),
      ),
      16.height,
      _restoreButton(ref),
    ];
  }

  List<Widget> _premiumContent(
    BuildContext context,
    WidgetRef ref,
    CustomerInfo customerInfo,
    AsyncValue<SubscriptionPackages> offeringsAsync,
  ) {
    final productId = customerInfo.activeSubscriptions.isNotEmpty
        ? customerInfo.activeSubscriptions.first
        : null;
    final subscription = productId != null
        ? customerInfo.subscriptionsByProductIdentifier[productId]
        : null;
    final storeProduct = _storeProductFor(offeringsAsync, productId);
    final managementUrl =
        customerInfo.managementURL ?? subscription?.managementURL;

    return [
      24.height,
      SubscriptionInfoCard.subscriptionType(
        titileLeading: SvgPicture.asset(
          Assets.icons.checkBadge,
          colorFilter: ColorFilter.mode(
            ColorManager.primaryButton,
            BlendMode.srcIn,
          ),
          width: 24,
          height: 24,
        ),
        title: subscription?.displayName ?? 'GetDockPay Pro',
        subtitle: subscription?.willRenew == true
            ? 'Your subscription will renew automatically'
            : 'Your subscription is active',
      ),
      16.height,
      if (subscription?.expiresDate != null)
        SubscriptionInfoCard.nextBilling(
          startingDate: subscription!.expiresDate!,
          billingDuration: _billingDuration(storeProduct),
          amount: CurrencyFormatter.format(storeProduct?.price ?? 0),
        ),
      // 16.height,
      // TODO: Implement local notification
      16.height,
      FeatureListCard(
        features: RevenueCatService.getFeaturedPlanItems(productId),
      ),
      Spacer(),
      GlobalButton(
        label: 'Manage Subscription',
        onPressed: managementUrl == null
            ? null
            : () async {
                final launched = await launchUrl(
                  Uri.parse(managementUrl),
                  mode: LaunchMode.externalApplication,
                );
                if (!launched) {
                  Utils.showErrorToast(
                    message: 'Could not open the manage page.',
                  );
                }
              },
      ),
      8.height,
      _restoreButton(ref),
    ];
  }

  Widget _restoreButton(WidgetRef ref) {
    return Center(
      child: TextButton(
        onPressed: () async {
          final service = ref.read(revenueCatServiceProvider);
          try {
            final info = await service.restorePurchases();
            Utils.showSuccessToast(
              message: service.isEntitled(info)
                  ? 'Purchases restored successfully'
                  : 'No purchases found to restore',
            );
          } catch (error) {
            Utils.showErrorToast(
              message: 'Something went wrong restoring purchases.',
            );
          }
        },
        child: Text(
          'Restore Purchases',
          style: TextStyle(
            color: ColorManager.subtextColor,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  StoreProduct? _storeProductFor(
    AsyncValue<SubscriptionPackages> offeringsAsync,
    String? productId,
  ) {
    if (productId == null) return null;
    final packages = offeringsAsync.value;
    for (final product in [
      packages?.monthly.storeProduct,
      packages?.yearly.storeProduct,
    ]) {
      if (product != null && product.identifier == productId) return product;
    }
    return null;
  }

  String _billingDuration(StoreProduct? product) {
    return switch (product?.subscriptionPeriod) {
      'P1M' => 'Per month',
      'P1Y' => 'Per year',
      'P1W' => 'Per week',
      _ => 'Per period',
    };
  }
}

class AvailableFeatureItem extends StatelessWidget {
  final String feature;
  final bool isAvailable;
  const AvailableFeatureItem({
    super.key,
    required this.feature,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isAvailable
              ? Icons.check_circle_outline_rounded
              : Icons.cancel_outlined,
          color: isAvailable
              ? ColorManager.primaryButton
              : ColorManager.errorColor,
        ),
        8.width,

        Text(
          feature,
          style: TextStyle(
            color: ColorManager.subtextColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: isAvailable ? null : .lineThrough,
          ),
        ),
      ],
    );
  }
}

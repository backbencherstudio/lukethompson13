import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/resource/constants/config.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/unlock_dialog.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

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

class RevenueCatService {
  Future<void> configure() async {
    if (kDebugMode) {
      await Purchases.setLogLevel(LogLevel.debug);
    }

    await Purchases.configure(
      PurchasesConfiguration(AppConfig.revenueCatApiKey),
    );
  }

  Future<Offering?> getOffering() async {
    final offerings = await Purchases.getOfferings();
    return offerings.getOffering(AppConfig.revenueCatOfferingId) ??
        offerings.current;
  }

  Future<CustomerInfo> getCustomerInfo() => Purchases.getCustomerInfo();

  Future<CustomerInfo> restorePurchases() => Purchases.restorePurchases();

  Future<PurchaseResult> purchase(Package package) async {
    return Purchases.purchase(PurchaseParams.package(package));
  }

  bool isEntitled(CustomerInfo customerInfo, {String? entitlementId}) {
    final id = entitlementId ?? AppConfig.revenueCatProEntitlementId;
    return customerInfo.entitlements.active.containsKey(id);
  }

  void addCustomerInfoUpdateListener(CustomerInfoUpdateListener listener) =>
      Purchases.addCustomerInfoUpdateListener(listener);

  void removeCustomerInfoUpdateListener(CustomerInfoUpdateListener listener) =>
      Purchases.removeCustomerInfoUpdateListener(listener);

  bool isPurchaseCancelled(Object error) =>
      error is PlatformException &&
      PurchasesErrorHelper.getErrorCode(error) ==
          PurchasesErrorCode.purchaseCancelledError;

  static List<String> getFeaturedPlanItems(String? selectedPlanId) {
    switch (selectedPlanId) {
      case AppConfig.revenueCatProYearlyPackageId || 'monthly':
        return _yearlyFeatures;
      case AppConfig.revenueCatProMonthlyPackageId || 'yearly':
        return _monthlyFeatures;
      default:
        return [];
    }
  }

  static Future<T?> showPayWallDialog<T>(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => UnlockDialog(
        onSubscribe: () {
          Navigator.of(context).pop();
          RevenueCatService.showPayWall(context);
        },
      ),
    );
  }

  static Future<T?> showPayWall<T extends Object?>(BuildContext context) async {
    return context.push(Routes.chooseSubscriptionPlan);
  }
}

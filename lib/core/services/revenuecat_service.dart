import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lukethompson/core/resource/constants/config.dart';
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
    final id = entitlementId ?? AppConfig.revenueCatEntitlementId;
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
      case AppConfig.revenueCatMonthlyPackageId:
        return _monthlyFeatures;
      case AppConfig.revenueCatYearlyPackageId:
        return _yearlyFeatures;
      default:
        return [];
    }
  }
}

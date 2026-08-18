import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/resource/constants/config.dart';
import 'package:lukethompson/core/services/revenuecat_service.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final revenueCatServiceProvider = Provider<RevenueCatService>((ref) {
  return RevenueCatService();
});

class SubscriptionPackages {
  final Package monthly;
  final Package yearly;

  const SubscriptionPackages({required this.monthly, required this.yearly});
}

final offeringPackagesProvider =
    AsyncNotifierProvider<OfferingPackagesNotifier, SubscriptionPackages>(
      OfferingPackagesNotifier.new,
    );

class OfferingPackagesNotifier extends AsyncNotifier<SubscriptionPackages> {
  @override
  Future<SubscriptionPackages> build() async {
    final service = ref.watch(revenueCatServiceProvider);
    final offering = await service.getOffering();
    if (offering == null) {
      throw StateError(
        'No RevenueCat offering found. Configure offering '
        '"${AppConfig.revenueCatOfferingId}" in the RevenueCat dashboard.',
      );
    }

    final monthly = _packageFor(
      offering,
      configuredId: AppConfig.revenueCatProMonthlyPackageId,
      predefined: offering.monthly,
      packageType: PackageType.monthly,
    );
    final yearly = _packageFor(
      offering,
      configuredId: AppConfig.revenueCatProYearlyPackageId,
      predefined: offering.annual,
      packageType: PackageType.annual,
    );
    if (monthly == null || yearly == null) {
      throw StateError(
        'RevenueCat offering "${offering.identifier}" is missing monthly/yearly '
        'packages. Available packages: '
        '${offering.availablePackages.map((p) => p.identifier).join(', ')}. '
        'Configure the missing packages in the RevenueCat dashboard.',
      );
    }
    return SubscriptionPackages(monthly: monthly, yearly: yearly);
  }

  Package? _packageFor(
    Offering offering, {
    required String configuredId,
    required Package? predefined,
    required PackageType packageType,
  }) {
    final exact = offering.getPackage(configuredId);
    if (exact != null) return exact;
    if (predefined != null) return predefined;
    for (final package in offering.availablePackages) {
      if (package.packageType == packageType) return package;
    }
    return null;
  }
}

final customerInfoProvider =
    AsyncNotifierProvider<CustomerInfoNotifier, CustomerInfo>(
      CustomerInfoNotifier.new,
    );

class CustomerInfoNotifier extends AsyncNotifier<CustomerInfo> {
  late final CustomerInfoUpdateListener _listener;

  @override
  Future<CustomerInfo> build() {
    final service = ref.watch(revenueCatServiceProvider);
    _listener = (customerInfo) => state = AsyncData(customerInfo);
    service.addCustomerInfoUpdateListener(_listener);
    ref.onDispose(() => service.removeCustomerInfoUpdateListener(_listener));
    return service.getCustomerInfo();
  }
}

final isProSubscriptionProvider = Provider<bool>((ref) {
  final customerInfo = ref.watch(customerInfoProvider).value;
  if (customerInfo == null) return false;
  return ref.watch(revenueCatServiceProvider).isEntitled(customerInfo);
});

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static const minPassLength = 8;
  static const appName = 'GetDockPay';
  static const bundleId = 'com.getdockpay.app'; // com.lukethompson.getdocpay

  // Links **************************************************************
  static const appPrivacyUrl = 'https://getdockpay.com/privacy';
  static const appContactUrl = 'https://getdockpay.com/contact';

  // Backend **************************************************************
  static const useProductionServerInDebug = false;
  static final serverBaseUrl = _required(
    kDebugMode && !useProductionServerInDebug
        ? 'SERVER_BASE_URL_DEV'
        : 'SERVER_BASE_URL',
  );

  // Maps **************************************************************
  static const mapProvider = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  // RevenueCat **************************************************************
  static const revenueCatOfferingId = 'default';
  static const subscriptionDialogDelay = 30;

  static final isRevenueCatEnabled = true;
  // static final isRevenueCatEnabled = !Platform.isAndroid;

  static const revenueCatProEntitlementId = 'GetDockPay Pro';
  static const revenueCatProMonthlyPackageId = 'getdockpay_pro_1m';
  static const revenueCatProYearlyPackageId = 'getdockpay_pro_1y';

  static final revenueCatApiKey = _required(
    Platform.isIOS ? 'REVENUECAT_API_KEY_IOS' : 'REVENUECAT_API_KEY_ANDROID',
  );

  static String _required(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw StateError('Missing required env variable: $key');
    }
    return value;
  }
}

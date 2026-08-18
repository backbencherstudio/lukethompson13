import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static const minPassLength = 8;
  static const appName = 'GetDocPay';
  static const bundleId = 'com.lukethompson.getdocpay';

  static final serverBaseUrl = _required('SERVER_BASE_URL');

  // Maps **************************************************************
  static const mapProvider = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  // RevenueCat **************************************************************
  static const revenueCatEntitlementId = 'GetDockPay Pro';
  static const revenueCatOfferingId = 'default';
  static const revenueCatMonthlyPackageId = 'monthly';
  static const revenueCatYearlyPackageId = 'yearly';
  static const subscriptionDialogDelay = 30;

  static final revenueCatApiKey = _required(
    Platform.isIOS ? 'REVENUECAT_API_KEY_IOS' : 'REVENUECAT_API_KEY_TEST',
  );

  static String _required(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw StateError('Missing required env variable: $key');
    }
    return value;
  }
}

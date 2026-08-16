class AppConfig {
  static const minPassLength = 8;
  static const appName = 'GetDocPay';
  static const bundleId = 'com.lukethompson.getdocpay';

  // Maps **************************************************************
  static const mapProvider = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  // RevenueCat **************************************************************
  static const revenueCatTestStoreID = 'test_yETJTczVHhSXqsIBciRfsXmBmep';
  static const revenueCatApiKey = revenueCatTestStoreID;
  static const revenueCatEntitlementId = 'GetDockPay Pro';
  static const revenueCatOfferingId = 'default';
  static const revenueCatMonthlyPackageId = 'monthly';
  static const revenueCatYearlyPackageId = 'yearly';
  static const subscriptionDialogDelay = 30;
}

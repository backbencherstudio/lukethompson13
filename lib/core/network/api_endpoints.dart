class ApiEndpoints {
  static const String baseUrl = "http://10.10.9.51:2004";
  // static const String baseUrl = "https://lukethompson.pixelstack.cloud";
  static const String apiURL = "$baseUrl/api";

  static const String getMe = '/auth/me';
  static const String updateUserProfile = '/auth/update';

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verifyUserEmailAddress = '/auth/verify-email';

  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyOtp = '/auth/check-otp';
  static const String resetForgottenPassword = '/auth/reset-password';

  static const String stoplogReport = '/stoplog/report';
  static const String stoplogHomeData = '/stoplog/home-data';
  static const String stoplog = '/stoplog';
  static const String stoplogActive = '/stoplog/active';
  static const String stoplogSingleId = '/stoplog/{id}';

  static const String claim = '/claim';
  static const String submitAClaim = '/claim/{id}/submit';
  static const String markAClaimAsPaid = '/claim/{id}/mark-paid';
  static const String markAClaimAsDenied = '/claim/{id}/mark-denied';
  static const String sendClaimFollowUpEmail = '/claim/{id}/follow-up';

  static const String submitARatingForAShipperFacility =
      '/shippers/ratings/{stop_log_id}';
  static const String shippersRatings = "/shippers/ratings";
  static const String searchShipperFacilities = "/shippers/search";
}

class ApiEndpoints {
  static const String baseUrl = "http://10.10.9.51:2004";
  static const String apiURL = "$baseUrl/api";

  static const String getMe = '/auth/me';
  static const String updateUserProfile = '/auth/update';

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verifyUserEmailAddress = '/auth/verify-email';

  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyOtp = '/auth/check-otp';
  static const String resetForgottenPassword = '/auth/reset-password';

  static const String stoplogRepost = '/stoplog/report';
  static const String stoplogHomeData = '/stoplog/home-data';

  //  static const String library = 'api/library/categories';
  //  static const String  suggestedVideo= 'api/library';
  //  static const String  prescriptionResume= 'api/prescription/resume';
  //  static const String  prescribe= 'api/prescription';
  // static String prescribedDetails(String id) => 'api/library/$id';
  // static String prescriptionDetails(String id) => 'api/prescription/$id';
  // static const String favourite = 'api/library/favorites';
  // static  String favouriteId(String id) => 'api/library/$id/favorite';
  // static String libraryProgress(String id) => 'api/library/$id/progress';
  // static  const String watchHistory = 'api/library/watch-history';
  // static  const String membership = 'api/membership/plans';
  // static  String memberShipId(String id) => 'api/membership/$id';
  // static const String notification = 'api/notification';
  // static const String deleteProfile = 'api/auth/me';
  // static const String changePassword = 'api/auth/change-password';
}

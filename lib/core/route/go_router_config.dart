import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/data/providers/providers.dart';
import 'package:lukethompson/presentation/auth/forgot_screen/view/forget_screen.dart';
import 'package:lukethompson/presentation/auth/login_screen/view/sing_in_screen.dart';
import 'package:lukethompson/presentation/auth/otp_screen/view/otp_screen.dart';
import 'package:lukethompson/presentation/auth/reset_password/view/reset_password_screen.dart';
import 'package:lukethompson/presentation/auth/singUp_screen/view/singUp_screen.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/log_stop_result_screen.dart';
import 'package:lukethompson/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:lukethompson/presentation/onboarding_screen/onboarding_screen2.dart';
import 'package:lukethompson/presentation/parent_screen/parent_screen.dart';
import 'package:lukethompson/presentation/profile/view/screen/edit_profile_screen.dart';
import 'package:lukethompson/presentation/profile/view/screen/help_and_support_screen.dart';
import 'package:lukethompson/presentation/profile/view/screen/manage_subscription_screen.dart';
import 'package:lukethompson/presentation/profile/view/screen/my_claim_screen.dart';
import 'package:lukethompson/presentation/profile/view/screen/privacy_and_policy_screen.dart';
import 'package:lukethompson/presentation/profile/view/screen/profile_landing_screen.dart';
import 'package:lukethompson/presentation/profile/view/screen/shipper_ratings_screen.dart';
import 'package:lukethompson/presentation/profile/view/widget/set_your_rate_screen.dart';
import 'package:lukethompson/presentation/reports/view/screen/reports_screen.dart';
import 'package:lukethompson/presentation/splash_screen/splash_screen.dart';
import 'package:lukethompson/presentation/start_subscription/view/add_card_screen.dart';
import 'package:lukethompson/presentation/start_subscription/view/choose_payment_method_screen.dart';
import 'package:lukethompson/presentation/start_subscription/view/choose_subscription_plan_screen.dart';
import 'package:lukethompson/presentation/start_subscription/view/subscription_success.dart';
import 'package:lukethompson/presentation/stops/view/screen/claim_detials_screen.dart';
import 'package:lukethompson/presentation/stops/view/screen/claim_review_screen.dart';
import 'package:lukethompson/presentation/stops/view/screen/client_review_screeen.dart';
import 'package:lukethompson/presentation/stops/view/screen/review_submitted_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final authChangeNotifier = _AuthChangeNotifier();

  ref.listen(authStateProvider, (_, _) {
    authChangeNotifier.notify();
  });

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.splash,
    refreshListenable: authChangeNotifier,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final isAuthenticated = authState.isAuthenticated;
      final location = state.matchedLocation;

      final isPublicRoute = switch (location) {
        Routes.splash ||
        Routes.onboarding1 ||
        Routes.onboarding2 ||
        Routes.signUp ||
        Routes.signIn ||
        Routes.forgotPassword ||
        Routes.otp ||
        Routes.resetPassword => true,
        _ => false,
      };

      if (!isAuthenticated && !isPublicRoute) {
        return Routes.signIn;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.onboarding1,
        builder: (context, state) => const OnboardingScreen1(),
      ),
      GoRoute(
        path: Routes.onboarding2,
        builder: (context, state) {
          final extra = state.extra as Map?;
          return OnboardingScreen2(
            waitTime: extra?['waitTime'] as String?,
            bilableRate: extra?['bilableRate'] as String?,
          );
        },
      ),
      GoRoute(
        path: Routes.signUp,
        builder: (context, state) => const SingupScreen(),
      ),
      GoRoute(
        path: Routes.signIn,
        builder: (context, state) => const SingInScreen(),
      ),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (context, state) => const ForgetScreen(),
      ),
      GoRoute(
        path: Routes.otp,
        builder: (context, state) => OtpScreen(
          argument: state.extra as OtpScreenArgument?,
        ),
      ),
      GoRoute(
        path: Routes.resetPassword,
        builder: (context, state) => ResetPasswordScreen(
          argument: state.extra as ResetPasswordArgument?,
        ),
      ),
      GoRoute(
        path: Routes.parent,
        builder: (context, state) => const ParentScreen(),
      ),
      GoRoute(
        path: Routes.claimDetails,
        builder: (context, state) => const ClaimDetialsScreen(),
      ),
      GoRoute(
        path: Routes.claimReview,
        builder: (context, state) => const ClaimReviewScreen(),
      ),
      GoRoute(
        path: Routes.rateShipper,
        builder: (context, state) => const RateShipperScreen(),
      ),
      GoRoute(
        path: Routes.reviewSubmitted,
        builder: (context, state) => const ReviewSubmitted(),
      ),
      GoRoute(
        path: Routes.logStopResult,
        builder: (context, state) => const LogStopResultScreen(),
      ),
      GoRoute(
        path: Routes.reports,
        builder: (context, state) => const ReportsScreen(),
      ),
      GoRoute(
        path: Routes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: Routes.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: Routes.setRate,
        builder: (context, state) => const SetYourRateScreen(),
      ),
      GoRoute(
        path: Routes.myClaims,
        builder: (context, state) => const MyClaimScreen(),
      ),
      GoRoute(
        path: Routes.manageSubscription,
        builder: (context, state) => const ManageSubscriptionScreen(),
      ),
      GoRoute(
        path: Routes.shipperRatings,
        builder: (context, state) => const ShipperRatingsScreen(),
      ),
      GoRoute(
        path: Routes.helpAndSupport,
        builder: (context, state) => const HelpAndSupportScreen(),
      ),
      GoRoute(
        path: Routes.privacyAndPolicy,
        builder: (context, state) => const PrivacyAndPolicyScreen(),
      ),
      GoRoute(
        path: Routes.chooseSubscriptionPlan,
        builder: (context, state) => const ChooseSubscriptionPlanScreen(),
      ),
      GoRoute(
        path: Routes.chooseSubscriptionPaymentMethod,
        builder: (context, state) => const ChoosePaymentMethodScreen(),
      ),
      GoRoute(
        path: Routes.subscriptionAddCard,
        builder: (context, state) => const SubcriptionAddCardScreen(),
      ),
      GoRoute(
        path: Routes.subscriptionSuccess,
        builder: (context, state) {
          final isFree = state.extra is Map
              ? (state.extra as Map)['isFree'] as bool? ?? false
              : false;
          return SubscriptionSuccess(isFree: isFree);
        },
      ),
    ],
  );
});

class _AuthChangeNotifier extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/string_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';

// Splash & Onboarding
import 'package:lukethompson/presentation/splash_screen/splash_screen.dart';
import 'package:lukethompson/presentation/onboarding_screen/onboarding_screen.dart';

// Auth
import 'package:lukethompson/presentation/auth/singUp_screen/view/singUp_screen.dart';
import 'package:lukethompson/presentation/auth/login_screen/view/sing_in_screen.dart';
import 'package:lukethompson/presentation/auth/forgot_screen/view/forget_screen.dart';
import 'package:lukethompson/presentation/auth/reset_password/view/reset_password_screen.dart';

// Parent
import 'package:lukethompson/presentation/parent_screen/parent_screen.dart';

// Stops
import 'package:lukethompson/presentation/stops/view/screen/claim_detials_screen.dart';
import 'package:lukethompson/presentation/stops/view/screen/claim_review_screen.dart';
import 'package:lukethompson/presentation/stops/view/screen/client_review_screeen.dart';
import 'package:lukethompson/presentation/stops/view/screen/review_submitted_screen.dart';

// Reports
import 'package:lukethompson/presentation/reports/view/screen/reports_screen.dart';

// Profile
import 'package:lukethompson/presentation/profile/view/screen/profile_landing_screen.dart';
import 'package:lukethompson/presentation/profile/view/screen/edit_profile_screen.dart';
import 'package:lukethompson/presentation/profile/view/screen/help_and_support_screen.dart';
import 'package:lukethompson/presentation/profile/view/screen/my_claim_screen.dart';
import 'package:lukethompson/presentation/profile/view/widget/set_your_rate_screen.dart';

// Subscription
import 'package:lukethompson/presentation/start_subscription/view/add_card_screen.dart';
import 'package:lukethompson/presentation/start_subscription/view/choose_payment_method_screen.dart';
import 'package:lukethompson/presentation/start_subscription/view/choose_subscription_plan_screen.dart';
import 'package:lukethompson/presentation/start_subscription/view/subscription_success.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // Splash & Onboarding
      case RoutesName.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutesName.onboardingScreen1:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen1());

      // Auth
      case RoutesName.singupScreen:
        return MaterialPageRoute(builder: (_) => const SingupScreen());
      case RoutesName.singInScreen:
        return MaterialPageRoute(builder: (_) => const SingInScreen());
      case RoutesName.forgetScreen:
        return MaterialPageRoute(builder: (_) => const ForgetScreen());
      case RoutesName.resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      // Parent
      case RoutesName.parentScreen:
        return MaterialPageRoute(builder: (_) => const ParentScreen());

      // Stops
      case RoutesName.claimDetails:
        return MaterialPageRoute(builder: (_) => const ClaimDetialsScreen());
      case RoutesName.claimReview:
        return MaterialPageRoute(builder: (_) => const ClaimReviewScreen());
      case RoutesName.rateShipper:
        return MaterialPageRoute(builder: (_) => const RateShipperScreen());
      case RoutesName.reviewSubmitted:
        return MaterialPageRoute(builder: (_) => const ReviewSubmitted());

      // Reports
      case RoutesName.reportsScreen:
        return MaterialPageRoute(builder: (_) => const ReportsScreen());

      // Profile
      case RoutesName.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case RoutesName.editProfileScreen:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case RoutesName.helpAndSupport:
        return MaterialPageRoute(builder: (_) => const HelpAndSupportScreen());
      case RoutesName.setRateScreen:
        return MaterialPageRoute(builder: (_) => const SetYourRateScreen());
      case RoutesName.myClaimScreen:
        return MaterialPageRoute(builder: (_) => const MyClaimScreen());

      // Subscription
      case RoutesName.chooseSubscriptionPlan:
        return MaterialPageRoute(
          builder: (_) => const ChooseSubscriptionPlanScreen(),
        );
      case RoutesName.chooseSubscriptionPaymentMethod:
        return MaterialPageRoute(
          builder: (_) => const ChoosePaymentMethodScreen(),
        );
      case RoutesName.subscriptionAddCard:
        return MaterialPageRoute(
          builder: (_) => const SubcriptionAddCardScreen(),
        );
      case RoutesName.subscriptionSuccess:
        bool isFree = false;
        if (routeSettings.arguments is Map) {
          isFree = (routeSettings.arguments as Map)['isFree'] as bool? ?? false;
        }
        return MaterialPageRoute(
          builder: (_) => SubscriptionSuccess(isFree: isFree),
        );

      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(StringManager.noRoute)),
        body: Center(child: Text(StringManager.noRoute)),
      ),
    );
  }
}

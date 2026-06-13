import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/string_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/presentation/auth/forgot_screen/view/forget_screen.dart';
import 'package:lukethompson/presentation/auth/login_screen/view/sing_in_screen.dart';
import 'package:lukethompson/presentation/auth/reset_password/view/reset_password_screen.dart';
import 'package:lukethompson/presentation/auth/singUp_screen/view/singUp_screen.dart';
import 'package:lukethompson/presentation/profile/view/widget/my_claim_screen.dart';

import 'package:lukethompson/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:lukethompson/presentation/parent_screen/parent_screen.dart';
import 'package:lukethompson/presentation/profile/view/screen/profile_screen.dart';
import 'package:lukethompson/presentation/profile/view/widget/edit_profile_screen.dart';
import 'package:lukethompson/presentation/profile/view/widget/set_your_rate.dart';
import 'package:lukethompson/presentation/reports/view/screen/reports_screen.dart';
import 'package:lukethompson/presentation/splash_screen/splash_screen.dart';
import 'package:lukethompson/presentation/start_subscription/view/add_card_screen.dart';
import 'package:lukethompson/presentation/start_subscription/view/choose_payment_method_screen.dart';
import 'package:lukethompson/presentation/start_subscription/view/choose_subscription_plan_screen.dart';
import 'package:lukethompson/presentation/start_subscription/view/subscription_success.dart';
import 'package:lukethompson/presentation/stops/view/widget/claim_detials_widget.dart';
import 'package:lukethompson/presentation/stops/view/widget/claim_review.dart';
import 'package:lukethompson/presentation/stops/view/widget/client_review.dart';
import 'package:lukethompson/presentation/stops/view/widget/review_submitted_widget.dart';



class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutesName.onboardingScreen1:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen1());
      case RoutesName.singupScreen:
        return MaterialPageRoute(builder: (_) => const SingupScreen());
      case RoutesName.singInScreen:
        return MaterialPageRoute(builder: (_) => const SingInScreen());
      case RoutesName.forgetScreen:
        return MaterialPageRoute(builder: (_) => const ForgetScreen());
      case RoutesName.resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case RoutesName.parentScreen :
        return MaterialPageRoute(builder: (_) => const ParentScreen());
      case RoutesName.claimDetails :
        return MaterialPageRoute(builder: (_) => const ClaimDetialsWidget());
      case RoutesName.claimReview :
        return MaterialPageRoute(builder: (_) => const ClaimReview());
      case RoutesName.clientReview :
        return MaterialPageRoute(builder: (_) => const ClientReview());
      case RoutesName.reviewSubmitted :
        return MaterialPageRoute(builder: (_) => const ReviewSubmitted());
      case RoutesName.reportsScreen:
        return MaterialPageRoute(builder: (_) => const ReportsScreen ());
      case RoutesName.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case RoutesName.editProfileScreen:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen ());
      case RoutesName.setRateScreen:
        return MaterialPageRoute(builder: (_) => const SetRateScreen());
      case RoutesName.myClaimScreen:
        return MaterialPageRoute(builder: (_) => const MyClaimScreen());
      case RoutesName.chooseSubscriptionPlan:
        return MaterialPageRoute(builder: (_) => const ChooseSubscriptionPlanScreen());
      case RoutesName.chooseSubscriptionPaymentMethod:
        return MaterialPageRoute(builder: (_) => const ChoosePaymentMethodScreen());
      case RoutesName.subscriptionAddCard:
        return MaterialPageRoute(builder: (_) => const SubcriptionAddCardScreen());
      case RoutesName.subscriptionSuccess:
        bool isFree = false;
        if (routeSettings.arguments is Map) {
          isFree = (routeSettings.arguments as Map)['isFree'] as bool? ?? false;
        }
        return MaterialPageRoute(builder: (_) => SubscriptionSuccess(isFree: isFree));

      // case RoutesName.otpScreen:
      //   final args = routeSettings.arguments;
      //   String? email;
      //   if (args is String) {
      //     email = args;
      //   } else if (args is Map) {
      //     final value = args['email'];
      //     if (value != null) email = value.toString();
      //   }
      //   return MaterialPageRoute(builder: (_) => OtpScreen(email: email?.trim()));
      // case RoutesName.newPasswordScreen:
      //   final args = routeSettings.arguments;
      //   String? email;
      //   String? token;
      //   if (args is Map) {
      //     final e = args['email'];
      //     final t = args['token'];
      //     if (e != null) email = e.toString();
      //     if (t != null) token = t.toString();
      //   }
      //   return MaterialPageRoute(
      //     builder: (_) => NewPasswordScreen(email: email?.trim(), token: token?.trim()),
      //   );
    
     
      
     
   
     

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

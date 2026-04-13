import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/resource/constants/string_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/presentation/auth/forgot_screen/view/forget_screen.dart';
import 'package:lukethompson/presentation/auth/login_screen/view/sing_in_screen.dart';
import 'package:lukethompson/presentation/auth/singUp_screen/view/singUp_screen.dart';
import 'package:lukethompson/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:lukethompson/presentation/splash_screen/splash_screen.dart';



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
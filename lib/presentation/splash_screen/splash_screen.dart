import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () async {
      // if (!mounted) return;
      // final token = await SharedPreferenceData.getToken();
      // final completed = await SharedPreferenceData.getOnboardingCompleted();
      Navigator.pushReplacementNamed(
        context,
        RoutesName.onboardingScreen1,
        // token != null && token !='null' && token.isNotEmpty ? RoutesName.parentScreen : completed ? RoutesName.signInScreen : RoutesName.onboardingScreen,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Assets.icons.splash.image()),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}


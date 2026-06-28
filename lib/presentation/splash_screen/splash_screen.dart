import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/data/sources/local/shared_preference/shared_preference.dart';
import 'package:lukethompson/gen/assets.gen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () async {
      if (!mounted) return;
      final token = await SharedPreferenceData.getToken();
      final completed = await SharedPreferenceData.getOnboardingCompleted();
      final destination = (token != null && token != 'null' && token.isNotEmpty)
          ? Routes.parent
          : completed
              ? Routes.signIn
              : Routes.onboarding1;
      context.go(destination);
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

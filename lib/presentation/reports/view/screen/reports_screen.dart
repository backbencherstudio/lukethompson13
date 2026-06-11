import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/presentation/custom_app_bar/custom_app_bar_screen.dart';

import 'package:lukethompson/presentation/reports/view/widget/custom_rab_screen1.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: CustomAppBarScreen(
        welcomeText: "Reports",
        welcomeFontSize: 22.sp,
        userName: "Know what waiting is costing you",
        userNameFontSize: 14.sp,
        userNameColor: const Color.fromARGB(255, 204, 204, 204),
        userNameFontWeight: FontWeight.w400,
      ),
      body: AppGradientBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
             
              SizedBox(height: 10.h),
              const Expanded(
                child: CustomTabScreen1(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/presentation/custom_app_bar/custom_app_bar_screen.dart';

class StopsScreen extends StatelessWidget {
  const StopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: CustomAppBarScreen(
        welcomeText: " All Stops",
        welcomeFontSize: 22.sp,
        userName: "Track every Log Stops",
        userNameFontSize: 14.sp,
        userNameColor: const Color.fromARGB(255, 204, 204, 204),
        userNameFontWeight: FontWeight.w400,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [ColorManager.secondary, ColorManager.primary],
          ),
        ),child:Column(
          children: [

            
          ],
        ) ,),
    );
  }
}
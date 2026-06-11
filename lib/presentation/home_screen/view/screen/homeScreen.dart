import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/image_manager.dart';
import 'package:lukethompson/presentation/custom_app_bar/custom_app_bar_screen.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/carusel_slider.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/tab_bar.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/unlock_dialog.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 15), () {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => UnlockDialog(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: CustomAppBarScreen(
        userName: "Radwan Rahman",
        welcomeText: "Welcome Back",
        profileImage: ImageManager.user,
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
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              CustomCarouselSlider(),
              SizedBox(height: 12.h),
              const Expanded(child: CustomTabScreen()),
            ],
          ),
        ),
      ),
    );
  }
}

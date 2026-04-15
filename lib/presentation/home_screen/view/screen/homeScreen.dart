import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/presentation/custom_app_bar/custom_app_bar_screen.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/carusel_slider.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/tab_bar.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: CustomAppBarScreen(),
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Column(
              children: [
            
                CustomCarouselSlider(),
                SizedBox(height: 10.h,),
                CustomTabScreen()
              ],
            ),
          ),
        ),
        
        )
    );
  }
}
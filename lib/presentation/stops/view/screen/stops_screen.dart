import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/presentation/custom_app_bar/custom_app_bar_screen.dart';
import 'package:lukethompson/presentation/stops/view/widget/walmart_card_widget.dart';

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [ColorManager.secondary, ColorManager.primary],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
             
Container(
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), 
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.topRight,
      colors: [Color(0xFF1D3D36), Color(0XFF18252A)],
    ),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
      color: Colors.white.withOpacity(0.05),
      width: 1,
    ),
  ),
  child: Row(
    children: [
      Icon(
        Icons.search_outlined,
        color: Colors.grey.withOpacity(0.7),
        size: 26,
      ),
      SizedBox(width: 12),
      Expanded(
        child: TextField(
          cursorColor: Colors.white,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            hintText: "Search Stops or ID...",
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.6),
              fontSize: 18,
            ),
         
            filled: false, 
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    ],
  ),
),
                SizedBox(height: 15.h),

               
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        WalmartCard(),
                        SizedBox(height: 15.h),
                        WalmartCard(),
                        SizedBox(height: 15.h),
                        WalmartCard(),
                        SizedBox(height: 15.h),
                        WalmartCard(),
                        SizedBox(height: 15.h),
                        WalmartCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
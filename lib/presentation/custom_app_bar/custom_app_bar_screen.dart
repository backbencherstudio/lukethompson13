import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class CustomAppBarScreen extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false, 
      title: Row(
        children: [
        
          CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.grey.shade800,
            backgroundImage: const AssetImage("assets/images/user_placeholder.png"), 
          ),
          SizedBox(width: 12.w),
          
         
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Welcome Back",
                style: TextStyle(
                  color: ColorManager.textColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 4.h,),
              Text(
                "Radwan Rahman",
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
      
    );
  }

 
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 10.h);
}
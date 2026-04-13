import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [ColorManager.secondary, ColorManager.primary],
          ),
        ),child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25.h,),
                  Center(
                    child: Text("Create New Account",style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.textColor
                    ),),
                  ),
                  SizedBox(height: 10.h,),
                  Center(child: Text("Please fill your detail information",style: TextStyle(fontSize:16.sp,color: ColorManager.subtextColor ),)),
              
                  SizedBox(height: 30.h,),
                  Text("Full Name",style: TextStyle(fontSize:16.sp,color: ColorManager.textColor,fontWeight: FontWeight.w700 ),),
                  SizedBox(height: 15.h,),
                  CustomTextFieldWidget(
                   hintText: "Enter your name",
                  ),
                  SizedBox(height: 15.h,),
                  Text("Email Address",style: TextStyle(fontSize:16.sp,color: ColorManager.textColor,fontWeight: FontWeight.w700 ),),
                  SizedBox(height: 15.h,),
                  CustomTextFieldWidget(
                   hintText: "Enter your email address",
                   suffix: Image.asset(IconManager.email,width: 24.w,height: 24.h,),
                  ),
                  SizedBox(height: 15.h,),
                  Text("Create Password",style: TextStyle(fontSize:16.sp,color: ColorManager.textColor,fontWeight: FontWeight.w700 ),),
                  SizedBox(height: 15.h,),
                  CustomTextFieldWidget(
                   hintText: "Create Password",
                   obsecure: true,
                   suffix: Icon(Icons.visibility_off,color: const Color.fromARGB(255, 172, 192, 208),),
                  ),
                  SizedBox(height: 15.h,),
                  Text("Re-enter Password",style: TextStyle(fontSize:16.sp,color: ColorManager.textColor,fontWeight: FontWeight.w700 ),),
                  SizedBox(height: 15.h,),
                  CustomTextFieldWidget(
                   hintText: "Re-enter password",
                   obsecure: true,
                   suffix: Icon(Icons.visibility_off,color: const Color.fromARGB(255, 172, 192, 208),),
                  ),
                  SizedBox(height: 15.h,),
                  SizedBox(
                    width: double.infinity,
                    height: 54.h,
                    child: ElevatedButton(
                      onPressed: () {
                         
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF39D77A),
                        foregroundColor: ColorManager.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already Have an account? ",style: TextStyle(fontSize: 16.sp,color: ColorManager.subtextColor),),
                        InkWell(
                          onTap: () {
                             Navigator.pushNamed(context, RoutesName.singInScreen);
                          },
                          child: Text("Login",style: TextStyle(fontSize: 16.sp,color: Color(0xFF39D77A),)))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    ),
    );
    
  }
}
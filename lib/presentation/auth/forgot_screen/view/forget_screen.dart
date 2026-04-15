import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/presentation/auth/otp_screen/view/otp_screen.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
   
    _emailController.dispose();
    super.dispose();
  }

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
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25.h),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          IconManager.arrowLeft,
                          width: 26.w,
                          height: 24.h,
                        ),
                      ),
                      SizedBox(width: 60.w),
                      Center(
                        child: Text(
                          "Back To Login",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  Center(
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.textColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      "Please enter your email address to reset password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorManager.subtextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "Email Address",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorManager.textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                
                  CustomTextFieldWidget(
                    hintText: "Enter your email address",
                    controller: _emailController, 
                    suffix: Image.asset(
                      IconManager.email,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                  SizedBox(height: 35.h),
                  SizedBox(
                    width: double.infinity,
                    height: 54.h,
                    child: ElevatedButton(
                      onPressed: () {
                   
                        if (_emailController.text.isNotEmpty) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                email: _emailController.text.trim(),
                              ),
                            ),
                          );
                        } else {
                        
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please enter your email")),
                          );
                        }
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
                        "Send OTP",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppGradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25.h),
                  Center(
                    child: Text(
                      "Create New Account",
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
                      "Please fill your detail information",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorManager.subtextColor,
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),
                  InputLabel("Full Name"),
                  SizedBox(height: 8.h),
                  CustomTextFieldWidget(hintText: "Enter your name"),
                  SizedBox(height: 15.h),
                  InputLabel("Email Address"),
                  SizedBox(height: 8.h),
                  CustomTextFieldWidget(hintText: "Enter your email address"),
                  SizedBox(height: 15.h),
                  InputLabel("Create Password"),
                  SizedBox(height: 8.h),
                  CustomTextFieldWidget(
                    hintText: "Create Password",
                    obsecure: true,
                    suffix: Icon(
                      Icons.visibility_off,
                      color: const Color.fromARGB(255, 172, 192, 208),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  InputLabel("Re-enter Password"),
                  SizedBox(height: 8.h),
                  CustomTextFieldWidget(
                    hintText: "Re-enter password",
                    obsecure: true,
                    suffix: Icon(
                      Icons.visibility_off,
                      color: const Color.fromARGB(255, 172, 192, 208),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  GlobalButton(
                    isDisabled: true,
                    label: "Register",
                    onPressed: () {},
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have an account? ",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: ColorManager.subtextColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.singInScreen,
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xFF39D77A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

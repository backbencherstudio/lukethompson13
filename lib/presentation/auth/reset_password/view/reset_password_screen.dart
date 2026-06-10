import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
                  SizedBox(height: 4.h),
                  const GlobalAppBar(title: "Back To Login"),
                  SizedBox(height: 24.h),
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
                      "Set your new password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorManager.subtextColor,
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  Text(
                    " Password",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorManager.textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  CustomTextFieldWidget(
                    hintText: "Enter Your Password",
                    obsecure: true,
                    suffix: Icon(
                      Icons.visibility_off,
                      color: const Color.fromARGB(255, 172, 192, 208),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    "Confirm Password",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorManager.textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  CustomTextFieldWidget(
                    hintText: "Confirm Password",
                    obsecure: true,
                    suffix: Icon(
                      Icons.visibility_off,
                      color: const Color.fromARGB(255, 172, 192, 208),
                    ),
                  ),

                  SizedBox(height: 35.h),
                  GlobalButton(
                    label: "Reset Password",
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        RoutesName.singInScreen,
                      );
                    },
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({
    super.key,
    this.email = 'j**e**@samplegmail.com',
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  String enteredOtp = '';

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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                   
                      child: Image.asset(IconManager.arrowLeft,width: 24.w,height: 24.h,)
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 44.w),
                          child: Text(
                            "Back to Login",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 48.h),
                Center(
                  child: Text(
                    "Enter Your OTP",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Center(
                  child: Text(
                    "To verify email address, please enter the OTP sent\n"
                    "to your email: ${widget.email}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      height: 1.55,
                      color: ColorManager.subtextColor,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Center(
                  child: OtpPinField(
                    key: _otpPinFieldController,
                    autoFillEnable: false,
                    textInputAction: TextInputAction.done,
                    onSubmit: (text) {
                      setState(() {
                        enteredOtp = text;
                      });
                    },
                    onChange: (text) {
                      setState(() {
                        enteredOtp = text;
                      });
                    },
                    onCodeChanged: (code) {
                      setState(() {
                        enteredOtp = code;
                      });
                    },
                    otpPinFieldStyle: OtpPinFieldStyle(
                      showHintText: true,
                      hintText: "",
                      hintTextColor: Colors.white54,
                      textStyle: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF39D77A),
                      ),
                      fieldPadding: 8.w,
                      fieldBorderRadius: 8.r,
                      fieldBorderWidth: 1.2,
                      activeFieldBackgroundColor:
                          Colors.white.withValues(alpha: 0.03),
                      defaultFieldBackgroundColor:
                          Colors.white.withValues(alpha: 0.03),
                      filledFieldBackgroundColor:
                          Colors.white.withValues(alpha: 0.03),
                      activeFieldBorderColor: const Color(0xFF39D77A),
                      defaultFieldBorderColor:
                          Colors.white.withValues(alpha: 0.65),
                      filledFieldBorderColor: const Color(0xFF39D77A),
                    ),
                    maxLength: 4,
                    showCursor: true,
                    cursorColor: const Color(0xFF39D77A),
                    showCustomKeyboard: false,
                    showDefaultKeyboard: true,
                    cursorWidth: 2,
                    fieldHeight: 52.h,
                    fieldWidth: 52.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    otpPinFieldDecoration:
                        OtpPinFieldDecoration.defaultPinBoxDecoration,
                  ),
                ),
                SizedBox(height: 22.h),
                Center(
                  child: Text(
                    "Haven't you got the OTP yet?",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: ColorManager.subtextColor,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Center(
                  child: InkWell(
                    onTap: () {
                      _otpPinFieldController.currentState?.clearOtp();
                      setState(() {
                        enteredOtp = '';
                      });
                    },
                    child: Text(
                      "Resend Code",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF39D77A),
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFF39D77A),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 36.h),
                SizedBox(
                  width: double.infinity,
                  height: 54.h,
                  child: ElevatedButton(
                    onPressed: enteredOtp.length == 4 ? () {
                      Navigator.pushReplacementNamed(context, RoutesName.resetPasswordScreen);
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF39D77A),
                      disabledBackgroundColor:
                          const Color(0xFF39D77A).withValues(alpha: 0.5),
                      foregroundColor: ColorManager.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
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

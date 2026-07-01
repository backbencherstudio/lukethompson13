import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/presentation/auth/reset_password/view/reset_password_screen.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/heading_section.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/data/providers/providers.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

enum OtpType { register, forgetPassword }

class OtpScreenArgument {
  final String email;
  final OtpType otpType;

  const OtpScreenArgument({this.email = '', required this.otpType});
}

class OtpScreen extends ConsumerStatefulWidget {
  static const otpLength = 6;

  final OtpScreenArgument? argument;

  const OtpScreen({super.key, this.argument});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  String enteredOtp = '';

  String get _email => widget.argument?.email ?? '';
  OtpType? get _otpType => widget.argument?.otpType;

  Future<void> _handleVerify() async {
    final otpType = _otpType;
    final email = _email;
    if (otpType == null) {
      context.showErrorSnackBar("Invalid OTP type");
      return;
    }

    final ctx = context;
    late final BaseResponse response;

    switch (otpType) {
      case OtpType.forgetPassword:
        response = await ref
            .read(checkOtpMutation)
            .run(CheckOtpRequest(email: email, otp: enteredOtp));
      case OtpType.register:
        response = await ref
            .read(verifyEmailMutation)
            .run(VerifyEmailRequest(email: email, token: enteredOtp));
    }

    if (!ctx.mounted) return;

    if (!response.success) {
      ctx.showErrorSnackBar(response.message);
    }

    switch (otpType) {
      case OtpType.forgetPassword:
        ctx.go(
          Routes.resetPassword,
          extra: ResetPasswordArgument(email: email, token: enteredOtp),
        );
        ctx.showSuccessSnackBar("OTP verified successfully");
      case OtpType.register:
        ctx.go(Routes.signIn);
        ctx.showSuccessSnackBar("Account Created successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(
        title: "Back To Login",
        onBackPressed: () => context.go(Routes.signIn),
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24.h),
                HeadingSection(
                  title: "Enter Your OTP",
                  subtitle:
                      "To verify email address, please enter \nthe OTP sent "
                      "to your email: $_email",
                ),
                SizedBox(height: 34.h),

                LayoutBuilder(
                  builder: (context, constraints) {
                    final totalPadding = 8.0 * (OtpScreen.otpLength - 1);
                    final fieldWidth =
                        ((constraints.maxWidth - totalPadding) /
                                OtpScreen.otpLength)
                            .clamp(36.0, 52.0);
                    return OtpPinField(
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
                        fieldPadding: 8,
                        fieldBorderRadius: 8.r,
                        fieldBorderWidth: 1.2,
                        activeFieldBackgroundColor: Colors.white.withValues(
                          alpha: 0.03,
                        ),
                        defaultFieldBackgroundColor: Colors.white.withValues(
                          alpha: 0.03,
                        ),
                        filledFieldBackgroundColor: Colors.white.withValues(
                          alpha: 0.03,
                        ),
                        activeFieldBorderColor: ColorManager.primaryButton,
                        defaultFieldBorderColor: Colors.white.withValues(
                          alpha: 0.65,
                        ),
                        filledFieldBorderColor: ColorManager.primaryButton,
                      ),
                      maxLength: OtpScreen.otpLength,
                      showCursor: true,
                      cursorColor: ColorManager.primaryButton,
                      showCustomKeyboard: false,
                      showDefaultKeyboard: true,
                      cursorWidth: 2,
                      fieldHeight: 52,
                      fieldWidth: fieldWidth,
                      mainAxisAlignment: MainAxisAlignment.center,
                      otpPinFieldDecoration:
                          OtpPinFieldDecoration.defaultPinBoxDecoration,
                    );
                  },
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
                GlobalButton(
                  label: "Verify",
                  isDisabled:
                      enteredOtp.length != OtpScreen.otpLength ||
                      ref.watch(authStateProvider).isLoading,
                  onPressed: _handleVerify,
                  // onPressed: () {
                  //   context.push(Routes.resetPassword);
                  // },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

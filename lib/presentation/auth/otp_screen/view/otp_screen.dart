import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/data/repositories/auth_provider.dart';
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
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);

    final response = await ref
        .read(authProvider.notifier)
        .verifyEmail(email: _email, token: enteredOtp);

    if (!mounted) return;

    if (response != null && response.success) {
      switch (_otpType) {
        case OtpType.forgetPassword:
          router.go(Routes.signIn);
        case OtpType.register:
        default:
          router.go(Routes.signIn);
      }

      messenger.showSnackBar(SnackBar(content: Text(response.message)));
    } else {
      final authState = ref.read(authProvider);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            ErrorHandle.formatErrorMessage(Exception(authState.error)),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppGradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                CustomAppBarNew(
                  title: "Back To Login",
                  onBack: () {
                    context.go(Routes.signIn);
                  },
                ),
                SizedBox(height: 24.h),
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
                    "To verify email address, please enter \nthe OTP sent "
                    "to your email: $_email",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      height: 1.55,
                      color: ColorManager.subtextColor,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
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
                      ref.watch(authProvider).isLoading,
                  onPressed: _handleVerify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

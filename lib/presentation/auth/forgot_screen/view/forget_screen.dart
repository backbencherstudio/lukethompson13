import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/utils/validators.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/heading_section.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:lukethompson/presentation/auth/otp_screen/view/otp_screen.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class ForgetScreen extends ConsumerStatefulWidget {
  const ForgetScreen({super.key});

  @override
  ConsumerState<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends ConsumerState<ForgetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onSendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    await reqOtpForForgetPassword(context, ref, email: email);
  }

  static Future<void> reqOtpForForgetPassword(
    BuildContext context,
    WidgetRef ref, {
    required String email,
  }) async {
    final (res, err) = await tryCatch(
      ref.read(forgotPasswordMutation).run(ForgotPasswordRequest(email: email)),
    );

    if (!context.mounted) return;

    if (res != null && res.success) {
      context.push(
        Routes.otp,
        extra: OtpScreenArgument(email: email, otpType: OtpType.forgetPassword),
      );
    } else {
      final msg = ErrorHandle.formatErrorMessage(
        err,
        defaultMessage:
            res?.message ??
            "Unable to send OTP. Please check your email and try again.",
      );

      context.showErrorSnackBar(msg);
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 24.h),
                  HeadingSection(
                    title: "Forgot Password",
                    subtitle:
                        "Please enter your email address to reset password",
                  ),
                  SizedBox(height: 34.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InputLabel('Email Address'),
                        SizedBox(height: 8.h),
                        CustomTextFieldWidget(
                          hintText: "Enter your email address",
                          controller: _emailController,
                          validator: Validators.email,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 35.h),
                  GlobalButton(label: "Send OTP", onPressed: _onSendOtp),
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

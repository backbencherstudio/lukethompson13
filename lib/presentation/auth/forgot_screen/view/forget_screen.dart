import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/heading_section.dart';
import 'package:lukethompson/data/models/auth.model.dart';
import 'package:lukethompson/data/providers/providers.dart';
import 'package:lukethompson/presentation/auth/login_screen/view/sing_in_screen.dart';
import 'package:lukethompson/presentation/auth/otp_screen/view/otp_screen.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class ForgetScreen extends ConsumerStatefulWidget {
  const ForgetScreen({super.key});

  @override
  ConsumerState<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends ConsumerState<ForgetScreen> {
  final TextEditingController _emailController = TextEditingController(
    text: kDebugMode ? SingInScreen.defaultEmail : null,
  );

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onSendOtp() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      context.showErrorSnackBar('Please enter your email');
      return;
    }

    final response = await ref
        .read(forgotPasswordMutation)
        .run(ForgotPasswordRequest(email: email));

    if (!mounted) return;

    if (response.success) {
      context.push(
        Routes.otp,
        extra: OtpScreenArgument(email: email, otpType: OtpType.forgetPassword),
      );
    } else {
      context.showErrorSnackBar(response.message);
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

                  InputLabel('Email Address'),
                  SizedBox(height: 8.h),
                  CustomTextFieldWidget(
                    hintText: "Enter your email address",
                    controller: _emailController,
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

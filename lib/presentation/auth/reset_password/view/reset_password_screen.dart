import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/resource/constants/config.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/heading_section.dart';
import 'package:lukethompson/data/models/auth.model.dart';
import 'package:lukethompson/data/providers/providers.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class ResetPasswordArgument {
  final String email;
  final String token;

  const ResetPasswordArgument({required this.email, required this.token});
}

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final ResetPasswordArgument? argument;

  const ResetPasswordScreen({super.key, this.argument});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _onReset() async {
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    final email = widget.argument?.email ?? '';
    final token = widget.argument?.token ?? '';

    if (email.isEmpty || token.isEmpty) {
      context.showErrorSnackBar("Invalid session");
      return;
    }

    if (password.length < AppConfig.minPassLength) {
      context.showErrorSnackBar(
        "Password must be at least ${AppConfig.minPassLength} characters",
      );
      return;
    }

    if (password != confirm) {
      context.showErrorSnackBar("Passwords do not match");
      return;
    }

    final mutation = ref.read(resetForgottenPasswordMutation);
    final response = await mutation.run(
      ResetPasswordRequest(email: email, token: token, password: password),
    );

    if (!mounted) return;

    if (response.success) {
      context.showSuccessSnackBar("Password reset successfully");
      context.go(Routes.signIn);
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
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 24.h),
                  HeadingSection(
                    title: "Reset Password",
                    subtitle: "Create your new password",
                  ),
                  SizedBox(height: 34.h),

                  InputLabel("Password"),
                  SizedBox(height: 8.h),
                  CustomTextFieldWidget(
                    controller: _passwordController,
                    hintText: "Enter Your Password",
                    obsecure: _obscurePassword,
                    suffix: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color.fromARGB(255, 172, 192, 208),
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),

                  SizedBox(height: 16.h),
                  InputLabel("Confirm Password"),
                  SizedBox(height: 8.h),
                  CustomTextFieldWidget(
                    controller: _confirmController,
                    hintText: "Confirm Password",
                    obsecure: _obscurePassword,
                  ),

                  SizedBox(height: 35.h),
                  GlobalButton(label: "Reset Password", onPressed: _onReset),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

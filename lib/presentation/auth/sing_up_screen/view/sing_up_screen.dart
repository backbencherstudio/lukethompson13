import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/utils/error.dart';
import 'package:lukethompson/core/utils/validators.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/auth_prompt.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:lukethompson/presentation/auth/otp_screen/view/otp_screen.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class SingupScreen extends ConsumerStatefulWidget {
  const SingupScreen({super.key});

  @override
  ConsumerState<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends ConsumerState<SingupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;
  final _nameController = TextEditingController(text: Testing.testUserName);
  final _emailController = TextEditingController(text: Testing.testUsserEmail);
  final _passwordController = TextEditingController(
    text: Testing.testUsserPassword,
  );
  final _confirmPasswordController = TextEditingController(
    text: Testing.testUsserPassword,
  );

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final (res, err) = await tryCatch(
      ref
          .read(registerMutation)
          .run(
            RegisterRequest(
              name: name,
              password: password,
              email: email,
              type: 'user',
            ),
          ),
    );

    if (!mounted) return;

    if (res != null && res.success) {
      context.push(
        Routes.otp,
        extra: OtpScreenArgument(email: email, otpType: OtpType.register),
      );
    } else {
      final msg = ErrorHandle.formatErrorMessage(
        err,
        defaultMessage:
            res?.message ?? "Unable to create your account. Plqease try again.",
      );
      context.showErrorSnackBar(msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authStateProvider).isLoading;

    return Scaffold(
      body: AppGradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
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
                    CustomTextFieldWidget(
                      textInputAction: TextInputAction.next,
                      hintText: "Enter your name",
                      controller: _nameController,
                      validator: Validators.name,
                    ),
                    SizedBox(height: 15.h),
                    InputLabel("Email Address"),
                    SizedBox(height: 8.h),
                    CustomTextFieldWidget(
                      textInputAction: TextInputAction.next,
                      hintText: "Enter your email address",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.email,
                    ),
                    SizedBox(height: 15.h),
                    InputLabel("Create Password"),
                    SizedBox(height: 8.h),
                    CustomTextFieldWidget(
                      textInputAction: TextInputAction.next,
                      hintText: "Create Password",
                      obsecure: _isPasswordHidden,
                      controller: _passwordController,
                      validator: Validators.password,
                      suffix: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        },
                        child: Icon(
                          _isPasswordHidden
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFFA8B7C7),
                          size: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    InputLabel("Re-enter Password"),
                    SizedBox(height: 8.h),
                    CustomTextFieldWidget(
                      textInputAction: TextInputAction.done,
                      hintText: "Re-enter password",
                      obsecure: _isPasswordHidden,
                      controller: _confirmPasswordController,
                      validator: (value) => Validators.confirmPassword(
                        value,
                        password: _passwordController.text,
                      ),
                      onFieldSubmitted: (_) => _handleRegister(),
                      suffix: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        },
                        child: Icon(
                          _isPasswordHidden
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFFA8B7C7),
                          size: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 42.h),
                    GlobalButton(
                      isLoading: isLoading,
                      label: "Register",
                      onPressed: _handleRegister,
                    ),
                    SizedBox(height: 20.h),

                    AuthPrompt(
                      message: "Already Have an account? ",
                      actionText: 'Login',
                      onPressed: () => context.go(Routes.signIn),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

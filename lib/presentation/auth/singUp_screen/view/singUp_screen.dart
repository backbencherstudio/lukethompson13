import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/auth_prompt.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/models/auth.model.dart';
import 'package:lukethompson/data/providers/providers.dart';
import 'package:lukethompson/presentation/auth/login_screen/view/sing_in_screen.dart';
import 'package:lukethompson/presentation/auth/otp_screen/view/otp_screen.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class SingupScreen extends ConsumerStatefulWidget {
  const SingupScreen({super.key});

  @override
  ConsumerState<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends ConsumerState<SingupScreen> {
  bool _isPasswordHidden = true;
  final _nameController = TextEditingController(
    text: kDebugMode ? SingInScreen.defaultUserName : null,
  );
  final _emailController = TextEditingController(
    text: kDebugMode ? SingInScreen.defaultEmail : null,
  );
  final _passwordController = TextEditingController(
    text: kDebugMode ? SingInScreen.defaultPassword : null,
  );
  final _confirmPasswordController = TextEditingController(
    text: kDebugMode ? SingInScreen.defaultPassword : null,
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
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    final router = GoRouter.of(context);
    final email = _emailController.text.trim();

    final response = await ref
        .read(registerMutation)
        .run(
          RegisterRequest(
            name: _nameController.text.trim(),
            password: _passwordController.text,
            email: email,
            type: 'user',
          ),
        );

    if (!mounted) return;

    if (response.success) {
      router.push(
        Routes.otp,
        extra: OtpScreenArgument(email: email, otpType: OtpType.register),
      );
    } else {
      context.showErrorSnackBar(response.message);
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
                    hintText: "Enter your name",
                    controller: _nameController,
                  ),
                  SizedBox(height: 15.h),
                  InputLabel("Email Address"),
                  SizedBox(height: 8.h),
                  CustomTextFieldWidget(
                    hintText: "Enter your email address",
                    controller: _emailController,
                  ),
                  SizedBox(height: 15.h),
                  InputLabel("Create Password"),
                  SizedBox(height: 8.h),
                  CustomTextFieldWidget(
                    hintText: "Create Password",
                    obsecure: _isPasswordHidden,
                    controller: _passwordController,
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
                    hintText: "Re-enter password",
                    obsecure: _isPasswordHidden,
                    controller: _confirmPasswordController,
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
                    isDisabled: isLoading,
                    label: "Register",
                    // onPressed: () {
                    //   context.go(
                    //     Routes.otp,
                    //     extra: {
                    //       'email': _emailController.text.trim(),
                    //       'ridirectPath': Routes.signIn,
                    //     },
                    //   );
                    // },
                    onPressed: _handleRegister,
                  ),
                  SizedBox(height: 20.h),

                  AuthPrompt(
                    message: "Already Have an account? ",
                    actionText: 'Login',
                    onPressed: () => context.pushReplacement(Routes.signIn),
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

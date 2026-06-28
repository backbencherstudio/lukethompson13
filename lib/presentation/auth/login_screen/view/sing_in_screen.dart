import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/repositories/auth_provider.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class SingInScreen extends ConsumerStatefulWidget {
  const SingInScreen({super.key});

  @override
  ConsumerState<SingInScreen> createState() => _SingInScreenState();

  static const defaultEmail = 'fabom85192@luxudata.com';
  static const defaultPassword = '12345678';
}

class _SingInScreenState extends ConsumerState<SingInScreen> {
  bool rememberMe = false;
  bool isPasswordHidden = true;
  final _emailController = TextEditingController(
    text: kDebugMode ? SingInScreen.defaultEmail : null,
  );
  final _passwordController = TextEditingController(
    text: kDebugMode ? SingInScreen.defaultPassword : null,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);

    await ref
        .read(authProvider.notifier)
        .login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

    if (!mounted) return;

    final authState = ref.read(authProvider);
    if (authState.error != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            ErrorHandle.formatErrorMessage(Exception(authState.error)),
          ),
        ),
      );
    } else if (authState.isAuthenticated) {
      router.go(Routes.parent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      body: AppGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Center(
                    child: Text(
                      "Welcome Back",
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
                      "Log in to your account",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorManager.subtextColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 34.h),
                  _buildLabel("Email Address"),
                  SizedBox(height: 14.h),
                  CustomTextFieldWidget(
                    controller: _emailController,
                    hintText: "Enter your email address",
                    suffix: Image.asset(
                      IconManager.email,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  _buildLabel("Password"),
                  SizedBox(height: 14.h),
                  CustomTextFieldWidget(
                    controller: _passwordController,
                    hintText: "Enter your password",
                    obsecure: isPasswordHidden,
                    suffix: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                      child: Icon(
                        isPasswordHidden
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xFFA8B7C7),
                        size: 22.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            rememberMe = !rememberMe;
                          });
                        },
                        borderRadius: BorderRadius.circular(6.r),
                        child: Container(
                          width: 18.w,
                          height: 18.w,
                          decoration: BoxDecoration(
                            color: rememberMe
                                ? const Color(0xFF39D77A)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                              color: rememberMe
                                  ? const Color(0xFF39D77A)
                                  : Colors.white70,
                            ),
                          ),
                          child: rememberMe
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 14.sp,
                                )
                              : null,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Remember Me",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: ColorManager.subtextColor,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          context.push(Routes.forgotPassword);
                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xFFFF4C45),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 42.h),
                  GlobalButton(
                    isDisabled: isLoading,
                    label: "Sign in",
                    onPressed: _handleLogin,
                  ),
                  SizedBox(height: 34.h),
                  Row(
                    children: [
                      Expanded(child: _divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          "Or Sign In with",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorManager.subtextColor,
                          ),
                        ),
                      ),
                      Expanded(child: _divider()),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  Row(
                    children: [
                      Expanded(
                        child: _SocialButton(
                          label: "google",
                          leading: Image.asset(
                            IconManager.google,
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: _SocialButton(
                          label: "Apple",
                          leading: Icon(
                            Icons.apple,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: ColorManager.subtextColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.push(Routes.signUp);
                          },
                          child: Text(
                            "Create",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF39D77A),
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

  Widget _buildLabel(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        color: ColorManager.textColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _divider() {
    return Container(height: 1, color: Colors.white.withValues(alpha: 0.35));
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget leading;

  const _SocialButton({required this.label, required this.leading});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leading,
          SizedBox(width: 10.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

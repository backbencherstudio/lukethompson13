import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/auth_prompt.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/heading_section.dart';
import 'package:lukethompson/data/providers/providers.dart';
import 'package:lukethompson/data/sources/local/shared_preference/shared_preference.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class SingInScreen extends ConsumerStatefulWidget {
  const SingInScreen({super.key});

  @override
  ConsumerState<SingInScreen> createState() => _SingInScreenState();

  static const defaultEmail = 'tetibap348@luxudata.com';
  static const defaultPassword = '12345678';
}

class _SingInScreenState extends ConsumerState<SingInScreen> {
  bool rememberMe = false;
  bool isPasswordHidden = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    final email = await SharedPreferenceData.getRememberMeEmail();
    if (mounted) {
      setState(() {
        rememberMe = email != null;
      });
      if (email != null) _emailController.text = email;
    }
  }

  void _persistRememberMe() {
    if (rememberMe) {
      SharedPreferenceData.setRememberMeEmail(_emailController.text.trim());
    } else {
      SharedPreferenceData.setRememberMeEmail(null);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final router = GoRouter.of(context);

    await ref
        .read(authStateProvider.notifier)
        .login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

    if (!mounted) return;

    final authState = ref.read(authStateProvider);
    if (authState.error != null) {
      context.showErrorSnackBar(
        ErrorHandle.formatErrorMessage(Exception(authState.error)),
      );
    } else if (authState.isAuthenticated) {
      _persistRememberMe();
      router.go(Routes.parent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      body: AppGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 24.h),
                  HeadingSection(
                    title: "Welcome Back",
                    subtitle: "Log in to your account",
                  ),
                  SizedBox(height: 34.h),
                  InputLabel("Email Address"),
                  SizedBox(height: 8.h),
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
                  InputLabel("Password"),
                  SizedBox(height: 8.h),
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
                      Transform.translate(
                        offset: Offset(-10, 0),
                        child: Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (v) => setState(() {
                                rememberMe = v!;
                                _persistRememberMe();
                              }),
                              activeColor: const Color(0xFF39D77A),
                              checkColor: Colors.white,
                              side: const BorderSide(color: Colors.white70),
                            ),
                            GestureDetector(
                              onTap: () => setState(() {
                                rememberMe = !rememberMe;
                                _persistRememberMe();
                              }),
                              child: Text(
                                "Remember Me",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: ColorManager.subtextColor,
                                ),
                              ),
                            ),
                          ],
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
                  SizedBox(height: 24.h),

                  AuthPrompt(
                    message: "Don't have an account? ",
                    actionText: 'Sign Up Now',
                    onPressed: () => context.pushReplacement(Routes.signUp),
                  ),
                ],
              ),
            ),
          ),
        ),
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

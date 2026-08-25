import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class GlobalButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final BorderSide? disabledBorderSide;
  final double? height;
  final double? width;
  final double? borderRadius;
  final TextStyle? textStyle;
  final BorderSide? borderSide;
  final bool isDisabled;
  final bool isLoading;
  final double? fontSize;

  const GlobalButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.foregroundColor = Colors.white,
    this.backgroundColor = ColorManager.primaryButton,
    this.disabledForegroundColor = ColorManager.disabledText,
    this.disabledBackgroundColor = ColorManager.secondary,
    this.height,
    this.width = double.infinity,
    this.borderRadius,
    this.textStyle,
    this.borderSide,
    this.disabledBorderSide,
    this.isDisabled = false,
    this.isLoading = false,
    this.fontSize,
  });

  const GlobalButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width = double.infinity,
    this.fontSize,
    this.textStyle,
    this.borderRadius,
    this.borderSide = BorderSide.none,
    this.isDisabled = false,
    this.isLoading = false,
  }) : backgroundColor = ColorManager.primaryButton,
       foregroundColor = Colors.white,
       disabledBackgroundColor = ColorManager.secondary,
       disabledForegroundColor = ColorManager.disabledText,
       disabledBorderSide = null;

  const GlobalButton.primaryOutlined({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width = double.infinity,
    this.fontSize,
    this.textStyle,
    this.borderRadius,
    this.borderSide = const BorderSide(color: ColorManager.primaryButton),
    this.foregroundColor = ColorManager.whiteColor,
    this.isDisabled = false,
    this.isLoading = false,
  }) : backgroundColor = Colors.transparent,
       disabledBackgroundColor = null,
       disabledForegroundColor = ColorManager.disabledText,
       disabledBorderSide = const BorderSide(color: ColorManager.disabledText);

  const GlobalButton.outlined({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width = double.infinity,
    this.fontSize,
    this.textStyle,
    this.borderRadius,
    this.borderSide = const BorderSide(color: ColorManager.greyText),
    this.foregroundColor = ColorManager.greyText,
    this.isDisabled = false,
    this.isLoading = false,
  }) : backgroundColor = Colors.transparent,
       disabledBackgroundColor = null,
       disabledForegroundColor = ColorManager.disabledText,
       disabledBorderSide = const BorderSide(color: ColorManager.disabledText);

  @override
  Widget build(BuildContext context) {
    final isEffectivelyDisabled = isDisabled || isLoading;
    return SizedBox(
      width: width,
      height: height ?? 52,
      child: ElevatedButton(
        onPressed: onPressed != null && !isEffectivelyDisabled
            ? onPressed
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          disabledForegroundColor: disabledForegroundColor,
          elevation: 0,
          side: isDisabled && disabledBorderSide != null
              ? disabledBorderSide
              : borderSide ?? BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 30.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isDisabled ? disabledForegroundColor : foregroundColor,
                ),
              )
            : Text(
                label,
                style:
                    textStyle ??
                    TextStyle(
                      fontSize: fontSize?.sp ?? 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
      ),
    );
  }
}

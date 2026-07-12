import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class GlobalButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
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
    this.color = ColorManager.primaryButton,
    this.foregroundColor,
    this.disabledBackgroundColor = ColorManager.secondary,
    this.height,
    this.width = double.infinity,
    this.borderRadius,
    this.textStyle,
    this.borderSide,
    this.isDisabled = false,
    this.isLoading = false,
    this.fontSize,
  });

  const GlobalButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width,
    this.fontSize,
    this.isLoading = false,
  }) : color = ColorManager.primaryButton,
       foregroundColor = Colors.white,
       disabledBackgroundColor = ColorManager.secondary,
       borderRadius = null,
       textStyle = null,
       borderSide = BorderSide.none,
       isDisabled = false;

  const GlobalButton.primaryOutlined({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width,
    this.borderSide = const BorderSide(color: ColorManager.primaryButton),
    this.foregroundColor = ColorManager.whiteColor,
    this.fontSize,
    this.isLoading = false,
  }) : color = Colors.transparent,
       disabledBackgroundColor = null,
       borderRadius = null,
       textStyle = null,
       isDisabled = false;

  const GlobalButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width,
    this.borderSide = const BorderSide(color: Color(0xFF8DA2B8)),
    this.foregroundColor = const Color(0xFF8DA2B8),
    this.fontSize,
    this.isLoading = false,
  }) : color = Colors.transparent,
       disabledBackgroundColor = null,
       borderRadius = null,
       textStyle = null,
       isDisabled = false;

  @override
  Widget build(BuildContext context) {
    final isEffectivelyDisabled = isDisabled || isLoading;
    return SizedBox(
      width: width,
      height: height ?? 52,
      child: ElevatedButton(
        onPressed:
            onPressed != null && !isEffectivelyDisabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: isDisabled ? disabledBackgroundColor : color,
          elevation: 0,
          side: borderSide ?? BorderSide.none,
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
                  color: foregroundColor ?? Colors.white,
                ),
              )
            : Text(
                label,
                style:
                    textStyle ??
                    TextStyle(
                      color: foregroundColor,
                      fontSize: fontSize?.sp ?? 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
      ),
    );
  }
}

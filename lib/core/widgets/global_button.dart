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
    this.fontSize,
  });

  const GlobalButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width = double.infinity,
    this.fontSize,
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
    this.width = double.infinity,
    this.borderSide = const BorderSide(color: ColorManager.primaryButton),
    this.foregroundColor = ColorManager.whiteColor,
    this.fontSize,
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
    this.width = double.infinity,
    this.borderSide = const BorderSide(color: Color(0xFF8DA2B8)),
    this.foregroundColor = const Color(0xFF8DA2B8),
    this.fontSize,
  }) : color = Colors.transparent,
       disabledBackgroundColor = null,
       borderRadius = null,
       textStyle = null,
       isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 52,
      child: ElevatedButton(
        onPressed: onPressed != null && !isDisabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          elevation: 0,
          side: borderSide ?? BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 30.r),
          ),
        ),
        child: Text(
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  const GlobalButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = const Color(0xFF33D17A),
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.height,
    this.width = double.infinity,
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 44.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 30.r),
          ),
        ),
        child: Text(
          label,
          style: textStyle ??
              TextStyle(
                color: foregroundColor ?? Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

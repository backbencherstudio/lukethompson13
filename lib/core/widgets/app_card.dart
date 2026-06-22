import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;
  final EdgeInsetsGeometry? margin;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorManager.cardBackground,
        border: Border.all(
          color: borderColor ?? Colors.white10,
          width: borderWidth ?? 1,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
      ),
      child: child,
    );
  }
}

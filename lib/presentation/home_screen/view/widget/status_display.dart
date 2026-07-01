import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';

class StatusDisplay extends StatelessWidget {
  final String message;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const StatusDisplay({
    super.key,
    required this.message,
    required this.color,
    this.padding,
  });

  factory StatusDisplay.error(String message, {EdgeInsetsGeometry? padding}) =>
      StatusDisplay(
        message: message,
        color: ColorManager.redColor,
        padding: padding,
      );

  factory StatusDisplay.success(
    String message, {
    EdgeInsetsGeometry? padding,
  }) => StatusDisplay(
    message: message,
    color: ColorManager.successColor,
    padding: padding,
  );

  factory StatusDisplay.muted(String message, {EdgeInsetsGeometry? padding}) =>
      StatusDisplay(
        message: message,
        color: ColorManager.greyText,
        padding: padding,
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
        child: Text(
          message,
          style: TextStyle(color: color),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

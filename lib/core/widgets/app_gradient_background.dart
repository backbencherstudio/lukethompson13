import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class AppGradientBackground extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const AppGradientBackground({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.center,
          colors: [ColorManager.secondary, ColorManager.primary],
        ),
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [ColorManager.secondary, ColorManager.primary],
          ),
        ),
    );
  }
}
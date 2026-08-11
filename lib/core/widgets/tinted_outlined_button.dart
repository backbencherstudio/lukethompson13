import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class TintedOutlinedButton extends StatelessWidget {
  const TintedOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = ColorManager.greyText,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        backgroundColor: color?.withValues(alpha: 0.1),
        side: BorderSide(color: color ?? Colors.grey, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}


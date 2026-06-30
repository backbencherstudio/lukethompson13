import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';

class LinkButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? color;
  final TextDecoration? decoration;

  const LinkButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
    this.decoration = TextDecoration.underline,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: color ?? context.scheme.primary,
        textStyle: context.bodyLarge.copyWith(
          decoration: decoration,
          decorationColor: color ?? context.scheme.primary,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        visualDensity: VisualDensity.compact,
      ),
      child: child,
    );
  }
}

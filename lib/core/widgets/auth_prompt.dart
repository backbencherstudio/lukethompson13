import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/link_button.dart';

class AuthPrompt extends StatelessWidget {
  const AuthPrompt({
    super.key,
    required this.message,
    required this.actionText,
    required this.onPressed,
    this.messageStyle,
    this.actionStyle,
  });

  final String message;
  final String actionText;
  final VoidCallback onPressed;

  final TextStyle? messageStyle;
  final TextStyle? actionStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            "$message ",
            style:
                messageStyle ??
                context.titleLarge.copyWith(color: ColorManager.subtextColor),
            textAlign: TextAlign.center,
          ),
          LinkButton(
            onPressed: onPressed,
            decoration: TextDecoration.none,
            child: Text(
              actionText,
              style:
                  actionStyle ??
                  context.titleLarge.copyWith(color: ColorManager.primaryButton),
            ),
          ),
        ],
      ),
    );
  }
}

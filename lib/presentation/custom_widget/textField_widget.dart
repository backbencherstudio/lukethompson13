import 'package:flutter/material.dart';

import '../../core/extensions/text_style_extension.dart';
import '../../core/resource/constants/color_manager.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffix;
  final bool? readonly;
  final bool? obsecure;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final bool autofocus;

  const CustomTextFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.suffix,
    this.readonly,
    this.obsecure,
    this.onTap,
    this.keyboardType,
    this.focusNode,
    this.textInputAction,
    this.validator,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      textInputAction: textInputAction,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      cursorColor: Colors.white,
      readOnly: readonly ?? false,
      obscureText: obsecure ?? false,
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        suffixIcon: suffix == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Align(widthFactor: 1, heightFactor: 1, child: suffix),
              ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
      ),
    );
  }
}

class InputLabel extends StatelessWidget {
  const InputLabel(
    this.label, {
    super.key,
    this.color = ColorManager.textColor,
    this.hint,
  });

  final String label;
  final String? hint;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        children: [
          if (hint != null)
            TextSpan(
              text: ' $hint',
              style: TextStyle(
                color: ColorManager.subtextColor.withValues(alpha: 0.8),
              ),
            ),
        ],
        style: context.labelLarge.copyWith(color: color),
      ),
    );
  }
}

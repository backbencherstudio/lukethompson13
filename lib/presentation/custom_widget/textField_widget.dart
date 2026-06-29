import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffix;
  final bool? readonly;
  final bool? obsecure;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;

  const CustomTextFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.suffix,
    this.readonly,
    this.obsecure,
    this.onTap,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      cursorColor: Colors.white,
      readOnly: readonly ?? false,
      obscureText: obsecure ?? false,
      onTap: onTap,
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
  final String label;
  const InputLabel(
    this.label, {
    super.key,
    this.color = ColorManager.textColor,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: context.labelLarge.copyWith(color: color));
  }
}

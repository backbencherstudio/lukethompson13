import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffix;
  final bool? readonly;
  final bool? obsecure;
  final VoidCallback? onTap;

  const CustomTextFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.suffix,
    this.readonly,
    this.obsecure,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: Colors.white10,
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        cursorColor: Colors.white,
        readOnly: readonly ?? false,
        obscureText: obsecure ?? false,
        onTap: onTap,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          filled: true,

          fillColor: Colors.transparent,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white60),
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
      ),
    );
  }
}

class InputLabel extends StatelessWidget {
  final String label;
  const InputLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16.sp,
        color: ColorManager.textColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffix;
  final bool? readonly;
  final bool ? obsecure;

  const CustomTextFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.suffix,
    this.readonly, this.obsecure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
     
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            ColorManager.fillColorTextFieldleft ,
            ColorManager.fillColorTextFielright 
          
          ],
        ),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        cursorColor: Colors.white,
        readOnly: readonly ?? false,
        obscureText: obsecure ?? false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
                  child: Align(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: suffix,
                  ),
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

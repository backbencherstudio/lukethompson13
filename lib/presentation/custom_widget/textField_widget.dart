import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget?suffix;
  final bool ? readonly;

  const CustomTextFieldWidget({super.key, this.controller, this.hintText, this.suffix, this.readonly});

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
        style: TextStyle(color: Colors.white, fontSize: 18),
        cursorColor: Colors.white,
        readOnly: readonly ?? false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: InputBorder.none,
     enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          filled: true, 
          fillColor: Colors.transparent, 
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white60),
          suffix: suffix
        ),
      ),
    );
  }
}
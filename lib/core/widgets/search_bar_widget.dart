import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final IconData? prefixIcon;
  final Color? iconColor;
  final Color? cursorColor;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final double? height;

  const SearchBarWidget({
    super.key,
    this.hintText = "Search Stops or ID...",
    this.controller,
    this.onChanged,
    this.prefixIcon = Icons.search_outlined,
    this.iconColor,
    this.cursorColor = Colors.white,
    this.hintStyle,
    this.textStyle,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF1D3D36), Color(0XFF18252A)],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
      ),
      child: Row(
        children: [
          Icon(
            prefixIcon,
            color: iconColor ?? Colors.grey.withOpacity(0.7),
            size: 26,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              cursorColor: cursorColor,
              style:
                  textStyle ??
                  const TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle:
                    hintStyle ??
                    const TextStyle(color: Color(0x999E9E9E), fontSize: 18),
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

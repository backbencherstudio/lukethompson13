import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final Color? iconColor;
  final Color? cursorColor;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final double? height;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final bool? enabled;

  const SearchBarWidget({
    super.key,
    this.hintText = "Search Stops or ID...",
    this.controller,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.prefixIcon = Icons.search_outlined,
    this.suffixIcon,
    this.iconColor,
    this.cursorColor = Colors.white,
    this.hintStyle,
    this.textStyle,
    this.height = 56,
    this.margin,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF1D3D36), Color(0XFF18252A)],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            prefixIcon,
            color: iconColor ?? Colors.grey.withValues(alpha: 0.7),
            size: 26,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              enabled: enabled,
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              onTap: onTap,
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
          if (suffixIcon != null) ...[const SizedBox(width: 12), ?suffixIcon],
        ],
      ),
    );
  }
}

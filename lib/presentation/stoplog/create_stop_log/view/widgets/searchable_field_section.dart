import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';

class SearchableFieldSection extends StatelessWidget {
  const SearchableFieldSection({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    required this.onTap,
    required this.enabled,
    this.onAction,
    required this.icon,
  });

  final String title;
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback? onTap;
  final VoidCallback? onAction;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.labelLarge),
        SizedBox(height: 4.h),
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: SearchBarWidget(
                prefixIcon: icon,
                enabled: enabled,
                hintText: hintText,
                controller: controller,
                focusNode: focusNode,
                onTap: onTap,
              ),
            ),
            if (onAction != null)
              IconButton.filled(
                onPressed: onAction,
                icon: const Icon(Icons.add_rounded, size: 26),
                style: IconButton.styleFrom(
                  fixedSize: Size.square(54),
                  backgroundColor: ColorManager.primaryButton,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

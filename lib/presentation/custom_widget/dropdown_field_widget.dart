import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';

class DropdownFieldWidget extends StatelessWidget {
  const DropdownFieldWidget({
    super.key,
    this.value,
    required this.hint,
    required this.items,
    this.onChanged,
    this.readonly = false,
  });

  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final bool readonly;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: readonly,
      child: DropdownButtonFormField<String?>(
        initialValue: value,
        hint: Text(
          hint,
          style: getRegular400Style12(
            color: ColorManager.hintTextColor,
            fontSize: 16,
          ),
        ),
        dropdownColor: ColorManager.tabBarBgColor,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white38,
          size: 22.sp,
        ),
        items: items.map((item) {
          return DropdownMenuItem<String?>(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

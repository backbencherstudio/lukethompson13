import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

final _radius = 12.r;

class PaymentOption extends StatelessWidget {
  final String title;
  final Widget leading;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentOption({
    super.key,
    required this.title,
    required this.leading,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_radius),
        border: Border.all(
          color: isSelected ? Colors.greenAccent : Colors.transparent,
        ),
      ),
      child: ListTile(
        leading: leading,
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        horizontalTitleGap: 2,
        trailing: RadioGroup<bool>(
          groupValue: isSelected,
          onChanged: (_) => onTap(),
          child: RadioTheme(
            data: RadioThemeData(
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return ColorManager.primaryButton;
                }
                return ColorManager.iconDisabled;
              }),
            ),
            child: Radio<bool>(value: true),
          ),
        ),
        onTap: isSelected ? null : onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radius),
        ),
        tileColor: Colors.white10,
      ),
    );
  }
}

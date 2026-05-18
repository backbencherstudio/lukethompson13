import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowContainer extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const RowContainer({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r), 
          color: isSelected ? Color(0xff33D17A) : Colors.white.withOpacity(0.05),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xff8DA2B8),
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
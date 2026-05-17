import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalClaimedWidget extends StatelessWidget {
  final String title;
  final String amount;
  final Color backgroundColor;
  final Color titleColor;
  final Color amountColor;

  const TotalClaimedWidget({
    Key? key,
    this.title = "",
    this.amount = "",
    this.backgroundColor = const Color(0xFF1A1F24), 
    this.titleColor = Colors.white,
    this.amountColor = const Color(0xFFF6A23E), 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24.0), 
        border: Border.all(color: Colors.white10), 
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20), 
            Text(
              amount,
              style: TextStyle(
                color: amountColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
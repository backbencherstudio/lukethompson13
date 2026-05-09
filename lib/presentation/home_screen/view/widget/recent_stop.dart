import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class RecentStop extends StatelessWidget {

  final String? title;
  final String? subtitle;
  final String? amount;
  final String? status;
  final IconData? icon;

 
  final Color? iconColor;
  final Color? iconBgColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? amountColor;
  final Color? statusTextColor;
  final Color? statusBgColor;
  final Color? borderColor;

  const RecentStop({
    super.key,
  
    this.title = "Walmart DC Shelbyville. TN",
    this.subtitle = "Thu Apr 24 4h 15m wait 2h 15m billable",
    this.amount = "\$135",
    this.status = "Good Payer",
    this.icon = Icons.business,


    this.iconColor = const Color(0xFF00A3FF),
    this.iconBgColor = const Color(0xFF1D232C),
    this.titleColor = Colors.white,
    this.subtitleColor = const Color(0XFF8DA2B8),
    this.amountColor = const Color(0xFF4ADE80),
    this.statusTextColor = const Color(0xFF4ADE80),
    this.statusBgColor = const Color(0x1A4ADE80),
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          width: 1,
          color: borderColor ?? ColorManager.backgroundColorgreen1.withValues(alpha: .2),
        ),
        color: ColorManager.boxColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
      
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
           
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: iconBgColor,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
               
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? "",
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle ?? "",
                        style: TextStyle(
                          color: subtitleColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  amount ?? "",
                  style: TextStyle(
                    color: amountColor,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
      
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    status ?? "",
                    style: TextStyle(
                      color: statusTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
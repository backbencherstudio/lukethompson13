import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_badge.dart';

class RecentStopData {
  final String title;
  final String subtitle;
  final String amount;
  final String? status;
  final String? icon;

  const RecentStopData({
    required this.title,
    required this.subtitle,
    required this.amount,
    this.status,
    this.icon = "assets/icons/building.svg",
  });
}

class RecentStop extends StatelessWidget {
  final RecentStopData data;

  final Color? iconColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? amountColor;
  final Color? borderColor;

  const RecentStop({
    super.key,
    required this.data,

    this.titleColor = Colors.white,
    this.iconColor = const Color(0xFF00A3FF),
    this.subtitleColor = const Color(0XFF8DA2B8),
    this.amountColor = ColorManager.primaryButton,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          width: 1,
          color:
              borderColor ??
              ColorManager.backgroundColorgreen1.withValues(alpha: .2),
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
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: iconColor?.withAlpha(30),
                  ),
                  child: SvgPicture.asset(
                    data.icon ?? Assets.icons.building,
                    colorFilter: iconColor != null
                        ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                        : null,
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        data.subtitle,
                        style: TextStyle(color: subtitleColor, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.amount,
                  style: TextStyle(
                    color: amountColor,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                StatusBadge(status: data.status ?? ""),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

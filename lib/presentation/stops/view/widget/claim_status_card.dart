import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/datetime_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/utils/date.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_badge.dart';

class ClaimStatusCard extends StatelessWidget {
  final SingleStoplogDetailData data;

  const ClaimStatusCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: .all(12),
      backgroundColor: ColorManager.primaryButton.withValues(alpha: 0.05),
      borderColor: ColorManager.primaryButton.withValues(alpha: 0.7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Claim Amount",
                style: TextStyle(color: Colors.white54, fontSize: 12.sp),
              ),
              StatusBadge(status: data.claim?.status),
            ],
          ),
          Text(
            CurrencyFormatter.format(data.claim?.amount),
            style: TextStyle(
              color: ColorManager.primaryButton,
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Divider(color: Colors.white.withValues(alpha: 0.1), thickness: 1),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 8.w,
            children: [
              VerticalInfo(
                label: "Sent",
                value: data.claim?.sentAt?.format() ?? '-',
              ),
              Expanded(
                child: VerticalInfo(
                  label: "Broker CC",
                  value: data.broker?.email ?? '-',
                ),
              ),
              VerticalInfo(
                label: "Via",
                value: data.claim?.sendMethod?.label ?? '-',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VerticalInfo extends StatelessWidget {
  final String label;
  final String value;
  const VerticalInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: ColorManager.subtextColor, fontSize: 11.sp),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            overflow: .ellipsis,
          ),
        ),
      ],
    );
  }
}

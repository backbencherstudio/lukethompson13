import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/datetime_extension.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/utils/date.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/section_header.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_badge.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/profile/view/widget/recent_activity.dart';

class ClaimListSection extends StatelessWidget {
  final List<ClaimItem> claims;
  final bool isLoadingMore;

  const ClaimListSection({
    super.key,
    required this.claims,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'Recent Activity'),
        SizedBox(height: 16.h),
        if (claims.isEmpty) StatusDisplay.muted('No recent activity found yet'),
        if (claims.isNotEmpty)
          ...claims.map(
            (e) => CustomJobCard(
              onTap: () {
                context.push(Routes.myClaimsDetail);
              },
              title: e.facilityName,
              dateTime: e.date.formatDateWithTime(),
              amount: CurrencyFormatter.format(e.amount),
              statusWidget: StatusBadge.small(status: e.status),
              amountColor: e.status.badgeColor,
              iconColor: e.status.badgeColor,
            ),
          ),
        if (isLoadingMore)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const Center(child: ActivityIndicator()),
          ),
      ],
    );
  }
}

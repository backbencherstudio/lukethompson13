import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/utils/date.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:lukethompson/presentation/reports/view/widget/claimed_widget.dart';

class ClaimStatsSection extends StatelessWidget {
  final ClaimListMetaData? metaData;

  const ClaimStatsSection({super.key, this.metaData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TotalClaimedWidget(
            title: "Pending Claims",
            amount: CurrencyFormatter.compact(
              metaData?.stats.pendingClaimsAmount,
            ),
            amountColor: ColorManager.warningColor,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: TotalClaimedWidget(
            title: "Settled This Week",
            amount: CurrencyFormatter.compact(
              metaData?.stats.settledThisWeekAmount,
            ),
            amountColor: ColorManager.primaryButton,
          ),
        ),
      ],
    );
  }
}

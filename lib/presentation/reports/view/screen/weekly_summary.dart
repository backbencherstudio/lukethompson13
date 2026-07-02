import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/utils/date.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/data/providers/report_queries.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/reports/view/widget/weekly_summary.dart';

class WeeklySummaryReport extends ConsumerWidget {
  const WeeklySummaryReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyReportSummary = ref.watch(getWeeklyReportSummaryQuery);

    return weeklyReportSummary.when(
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
      loading: () => const Center(child: ActivityIndicator()),
      error: (e, _) => StatusDisplay.error(e.toString()),
      data: (data) {
        if (data == null) {
          return StatusDisplay.muted('No Weekly Summary data found');
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
          child: Column(
            children: [
              WeeklySummaryWidget(
                title: "Total Waiting",
                value: data.totalWaitingText,
                subtitle: "This Week",
                valueColor: ColorManager.hoursWaiting,
              ),
              12.height,

              WeeklySummaryWidget(
                title: "Detention Captured",
                value: CurrencyFormatter.format(data.detentionCaptured),
                subtitle: "Recovered revenue",
                valueColor: ColorManager.primaryButton,
              ),
              12.height,
              WeeklySummaryWidget(
                icon: IconManager.revenueIcon,
                title: "Revenue Lost",
                value: CurrencyFormatter.format(data.revenueLost),
                subtitle: "Still Hurting margin",
                valueColor: ColorManager.errorColor,
              ),
              12.height,
              WeeklySummaryWidget(
                icon: IconManager.worstStop,
                titleColor: ColorManager.errorColor,
                title: "Top Worst Stop",
                value: data.topWorstStop?.facilityName ?? "--",
                subtitle:
                    "${data.topWorstStop?.waitingTimeText ?? "0h 0m"} waiting",
                backgroundColor: ColorManager.errorColor.withValues(
                  alpha: 0.12,
                ),
                borderColor: ColorManager.errorColor,
                subtitleColor: ColorManager.subtextColor,
              ),
              16.height,
            ],
          ),
        );
      },
    );
  }
}

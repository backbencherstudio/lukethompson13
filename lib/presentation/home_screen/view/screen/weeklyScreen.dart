import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/utils/date.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/section_header.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/data/providers/stoplog_queries.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/detention_grid.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/detention_widget.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/recent_stop.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/weekly_activity_chart.dart';
import 'package:lukethompson/presentation/parent_screen/parent_screen.dart';

class Weeklyscreen extends ConsumerWidget {
  const Weeklyscreen({super.key, required this.period});

  final HomeDataPeriod period;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overviewAsync = ref.watch(getStoplogHomeOverviewQuery(period));
    final recentStops = ref.watch(
      getStoplogListQuery(StopLogListParams(limit: 10)),
    );

    return overviewAsync.when(
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
      loading: () => const Center(child: ActivityIndicator()),
      error: (e, _) => StatusDisplay.error('Failed to load overview data'),
      data: (overview) {
        final d = overview;
        if (d == null) {
          return StatusDisplay.muted('No overview data available');
        }

        final detentionData = [
          DetentionData(
            imagePath: IconManager.detention,
            title: "Detention Owed",
            value: CurrencyFormatter.format(d.totalDetention),
            subtitle:
                "${d.totalStops} stops logged (${d.claimedStops} claimed)",
          ),
          DetentionData(
            imagePath: IconManager.revenueLost,
            title: "Revenue Lost",
            value: CurrencyFormatter.format(d.totalLost),
            subtitle: "Unpaid detention so far",
            valueColor: ColorManager.redColor,
          ),
          DetentionData(
            title: "Hours Waiting",
            value: d.totalHours,
            subtitle: "Avg ${d.avgHoursPerStopText} per stop",
            valueColor: ColorManager.hoursWaiting,
          ),
          DetentionData(
            title: "Collection Rate",
            value: ValueFormatter.asPercentage(d.collectionRate),
            subtitle: "${ValueFormatter.asPercentage(d.collectionRateChange)} vs last week",
            valueColor: ColorManager.collectionRate,
          ),
        ];

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              DetentionGrid(data: detentionData),
              SizedBox(height: 12),
              WeeklyActivityChart(chartData: d.weeklyActivity),
              SizedBox(height: 12),
              SectionHeader(
                title: 'Recent Stops',
                action: TextButton(
                  onPressed: () {
                    ref.read(parentScreenIndexProvider.notifier).goToStops();
                  },
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(fontWeight: .w700, fontSize: 14.sp),
                  ),
                  child: Text('See All'),
                ),
              ),
              RecentStopList(value: recentStops),
            ],
          ),
        );
      },
    );
  }
}

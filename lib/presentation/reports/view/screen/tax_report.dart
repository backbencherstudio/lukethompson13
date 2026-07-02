import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/utils/date.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/data/models/report/report.model.dart';
import 'package:lukethompson/data/providers/report_queries.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/reports/view/widget/claimed_widget.dart';
import 'package:lukethompson/presentation/reports/view/widget/revenue_realization.dart';
import 'package:lukethompson/presentation/reports/view/widget/tax_period_selector.dart';
import 'package:lukethompson/presentation/reports/view/widget/weekly_summary.dart';

import '../../providers/tax_report_filter.dart';

class TaxReport extends ConsumerWidget {
  const TaxReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(taxReportFilterProvider);
    final taxDataAsync = ref.watch(
      getTaxReportSummaryQuery(switch (filter.type) {
        DateRangeType.monthly => TaxReportDataPeriod.monthly,
        DateRangeType.yearly => TaxReportDataPeriod.yearly,
      }),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
      child: Column(
        children: [
          TaxPeriodSelector(
            selectedType: filter.type,
            onTypeChanged: (type) =>
                ref.read(taxReportFilterProvider.notifier).setType(type),
          ),
          12.height,
          taxDataAsync.when(
            skipLoadingOnRefresh: true,
            skipLoadingOnReload: true,
            loading: () => const Center(child: ActivityIndicator()),
            error: (e, _) => StatusDisplay.error(e.toString()),
            data: (data) {
              if (data == null) {
                return StatusDisplay.muted('No Tax Report data found');
              }

              return Column(
                children: [
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 7 / 4,
                        ),
                    children: [
                      TotalClaimedWidget(
                        title: "Total Claimed",
                        amount: CurrencyFormatter.format(data.totalClaimed),
                        amountColor: ColorManager.warningColor,
                      ),
                      TotalClaimedWidget(
                        title: "Total Collection",
                        amount: CurrencyFormatter.format(data.totalCollected),
                        amountColor: ColorManager.primaryButton,
                      ),
                      TotalClaimedWidget(
                        title: "Collection Rate",
                        amount: ValueFormatter.asPercentage(
                          data.collectionRate,
                        ),
                      ),
                      TotalClaimedWidget(
                        title: "Avg Days to Pay",
                        amount: CurrencyFormatter.format(data.avgDaysToPay),
                      ),
                    ],
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
                  RevenueRealizationChart(chartData: data.revenueRealization),
                ],
              );
            },
          ),

          16.height,
        ],
      ),
    );
  }
}

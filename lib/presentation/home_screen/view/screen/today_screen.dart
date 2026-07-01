import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/section_header.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/detention_grid.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/detention_widget.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/recent_stop.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_badge.dart';

final _detentiosData = [
  DetentionData(
    imagePath: IconManager.detention,
    title: "Detention Owed",
    value: "\$225",
    subtitle: "\$50/hr rate",
  ),
  DetentionData(
    imagePath: IconManager.revenueLost,
    title: "Revenue Lost",
    value: "\$225",
    subtitle: "Unrecovered time costs",
    valueColor: ColorManager.redColor,
  ),
];

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key, this.data});

  final HomeDataOverview? data;

  @override
  Widget build(BuildContext context) {
    final recentStopData = [
      const RecentStopData(
        title: "Walmart DC Shelbyville. TN",
        subtitle: "Thu Apr 24 4h 15m wait 2h 15m billable",
        amount: "\$135",
        status: "Good Payer",
      ),
      const RecentStopData(
        title: "FedEx Memphis Hub",
        subtitle: "Fri Apr 25 3h 30m wait 1h 45m billable",
        amount: "\$98",
        status: "Average Payer",
      ),
      const RecentStopData(
        title: "Amazon Fulfillment Center",
        subtitle: "Mon Apr 28 5h 00m wait 3h 00m billable",
        amount: "\$210",
        status: "Poor Payer",
      ),
      const RecentStopData(
        title: "UPS Louisville Hub",
        subtitle: "Tue Apr 29 2h 45m wait 1h 30m billable",
        amount: "\$75",
        status: "Good Payer",
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DetentionGrid(data: _detentiosData),
            SizedBox(height: 16.h),

            SectionHeader(
              title: 'Recent Stops',
              action: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontWeight: .w700, fontSize: 14.sp),
                ),
                child: Text('See All'),
              ),
            ),

            ...List.generate(
              recentStopData.length,
              (i) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: RecentStop(
                  data: recentStopData[i],
                  rightAction: StatusBadge(
                    status: recentStopData[i].status ?? "",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

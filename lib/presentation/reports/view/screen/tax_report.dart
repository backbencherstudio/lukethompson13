import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/presentation/reports/view/widget/claimed_widget.dart';
import 'package:lukethompson/presentation/reports/view/widget/revenue_realization.dart';
import 'package:lukethompson/presentation/reports/view/widget/weekly_summary.dart';

import '../widget/custome_date_selector.dart';

class TaxReport extends StatelessWidget {
  const TaxReport({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
      CustomDateSelector (),
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
        child: Row(
          children: [
            Expanded(child: TotalClaimedWidget (
              title: "Total Claimed",
              amount: "\$600",
            )),
            SizedBox(width: 10.h,),
            Expanded(child: TotalClaimedWidget (
              title: "Total Collection",
              amount: "\$225",
              amountColor: Color(0xff33D17A),
            ))
          ],
        ),
      ),
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
        child: Row(
          children: [
            Expanded(child: TotalClaimedWidget (
              title: "Collection Rate",
              amount: "45%",
              amountColor: Colors.white,
            )),
            SizedBox(width: 10.h,),
            Expanded(child: TotalClaimedWidget (
              title: "Avg Days to Pay",
              amount: "\$25",
              amountColor: Colors.white,
            ))
          ],
        ),
      ),
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: WeeklySummaryWidget(
                icon: IconManager.revenueIcon,
                title: "Revenue Lost",
                value: "\$225",
                subtitle: "Still Hurting margin",
                valueColor: Color(0XFFFF5C6C),
                borderColor: Color(0xff272C36),
              ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: RevenueRealizationChart(),
      ),SizedBox(height: 25.h,)
      ]),
    );
  }
}

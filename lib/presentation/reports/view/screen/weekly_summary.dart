import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/presentation/reports/view/widget/weekly_summary.dart';

class WeeklySummary extends StatelessWidget {
  const WeeklySummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
      child: Column(
        children: [
          WeeklySummaryWidget(
            title: "Total Waiting",
            value: "14.5 Hrs",
            subtitle: "This Week",
            valueColor: Color(0XFFFFB547),
            borderColor: Color(0xff272C36),
          ),
          12.height,

          WeeklySummaryWidget(
            title: "Detention Captured",
            value: "\$225",
            subtitle: "Recovered revenue",
            valueColor: Color(0XFF33D17A),
            borderColor: Color(0xff272C36),
          ),
          12.height,
          WeeklySummaryWidget(
            icon: IconManager.revenueIcon,
            title: "Revenue Lost",
            value: "\$225",
            subtitle: "Still Hurting margin",
            valueColor: Color(0XFFFF5C6C),
            borderColor: Color(0xff272C36),
          ),
          12.height,
          WeeklySummaryWidget(
            icon: IconManager.worstStop,
            titleColor: Color(0XFFFF5C6C),
            title: "Top Worst Stop",
            value: "Cold Storage Solutions",
            subtitle: "3 hrs waiting",
            backgroundColor: Color(0XFF1E1520),
            borderColor: Color(0XFFFF5C6C),
            subtitleColor: Colors.white,
          ),
          16.height,
        ],
      ),
    );
  }
}

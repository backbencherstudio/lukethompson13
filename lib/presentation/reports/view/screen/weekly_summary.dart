import 'package:flutter/material.dart';
import 'package:lukethompson/presentation/reports/view/widget/weekly_summary.dart';

class WeeklySummary extends StatelessWidget {
  const WeeklySummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeeklySummaryWidget(
          title: "Total Waiting",
          value: "14.5 Hrs",
          subtitle: "This Week",
          
        )
      ],
    );
  }
}
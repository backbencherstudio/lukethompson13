import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_tab_bar.dart';
import 'package:lukethompson/presentation/reports/view/screen/tax_report.dart';
import 'package:lukethompson/presentation/reports/view/screen/weekly_summary.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GlobalAppBar(
        title: 'Reports',
        subTitle: 'Know what waiting is costing you',
        hideBackButton: true,
      ),
      body: AppGradientBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              SizedBox(height: 10.h),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.screenPadding,
                ),
                child: GlobalTabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: "Weekly Summary"),
                    Tab(text: "Tax Report"),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [WeeklySummaryReport(), TaxReport()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/presentation/reports/view/screen/tax_report.dart';
import 'package:lukethompson/presentation/reports/view/screen/weekly_summary.dart';


class CustomTabScreen1 extends StatefulWidget {
  const CustomTabScreen1({super.key});

  @override
  State<CustomTabScreen1> createState() => _CustomTabScreenState();
}

class _CustomTabScreenState extends State<CustomTabScreen1> with SingleTickerProviderStateMixin {
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
    return Column( 
      children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Container(
            width: double.infinity,
            height: 50.h,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: ColorManager.tabBarBgColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: const Color(0xFF2ECC71),
                borderRadius: BorderRadius.circular(25),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: ColorManager.textColor,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: "Weekly Summary"),
                Tab(text: "Tax Report"),
              ],
            ),
          ),
        ),

      
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              WeeklySummary(), 
              TaxReport (),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/global_tab_bar.dart';
import 'package:lukethompson/presentation/home_screen/view/screen/today_screen.dart';
import 'package:lukethompson/presentation/home_screen/view/screen/weeklyScreen.dart';

class CustomTabScreen extends StatefulWidget {
  const CustomTabScreen({super.key});

  @override
  State<CustomTabScreen> createState() => _CustomTabScreenState();
}

class _CustomTabScreenState extends State<CustomTabScreen>
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
          child: GlobalTabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Today'),
              Tab(text: 'Weekly'),
            ],
          ),
        ),

        SizedBox(height: 16.h),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [TodayScreen(), Weeklyscreen()],
          ),
        ),
      ],
    );
  }
}

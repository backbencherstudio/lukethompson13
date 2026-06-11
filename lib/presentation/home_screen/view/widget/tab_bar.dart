import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
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
        // TabBar Container
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF26323D),
              borderRadius: BorderRadius.circular(34),
            ),
            child: TabBar(
              labelStyle: TextStyle(fontWeight: .w700, fontSize: 16),
              padding: EdgeInsets.all(6),
              indicatorPadding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 2,
              ),
              splashBorderRadius: BorderRadius.circular(28),
              controller: _tabController,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                color: ColorManager.primaryButton,
                borderRadius: BorderRadius.circular(28),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: const Color(0xFF9CA8B3),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: 'Today'),
                Tab(text: 'Weekly'),
              ],
            ),
          ),
        ),

        SizedBox(height: 16.h),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TodayScreen(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Weeklyscreen(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

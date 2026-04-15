import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabScreen extends StatefulWidget {
  const CustomTabScreen({super.key});

  @override
  State<CustomTabScreen> createState() => _CustomTabScreenState();
}

class _CustomTabScreenState extends State<CustomTabScreen> with SingleTickerProviderStateMixin {
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
 
    return Padding(
      padding:  EdgeInsets.all(8.r),
      child: Column(
        children: [
         
          Center(
            child: Container(
              width: double.infinity,
              height: 50.h,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2124), 
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding:  EdgeInsets.all(2.r),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: const Color(0xFF2ECC71), 
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent, 
                  tabs: const [
                    Tab(text: "Today"),
                    Tab(text: "Weekly"),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 10),
      
        
          SizedBox(
            height: 400, 
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(child: Text("Today's Data List", style: TextStyle(color: Colors.white))),
                Center(child: Text("Weekly Data List", style: TextStyle(color: Colors.white))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
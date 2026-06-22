import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/section_header.dart';
import 'package:lukethompson/presentation/profile/view/widget/recent_activity.dart';
import 'package:lukethompson/presentation/profile/view/widget/row_container.dart';
import 'package:lukethompson/presentation/reports/view/widget/claimed_widget.dart';

class MyClaimScreen extends StatefulWidget {
  const MyClaimScreen({super.key});

  @override
  State<MyClaimScreen> createState() => _MyClaimScreenState();
}

class _MyClaimScreenState extends State<MyClaimScreen> {
  int selectedIndex = 0;
  int isAmazonSelected = -1;

  final List<String> categories = [
    "All(12)",
    "Submitted (4)",
    "Draft (2)",
    "Paid",
    "Rejected",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(
        title: 'My Claim',
        subTitle: "Track every detention claim you've filed",
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: .symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [Color(0xFF1D3D36), Color(0XFF18252A)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.05),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_outlined,
                        color: Colors.grey.withOpacity(0.7),
                        size: 26,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: TextField(
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          decoration: InputDecoration(
                            hintText: "Search Stops or ID...",
                            hintStyle: TextStyle(
                              color: Color(0x999E9E9E),
                              fontSize: 18,
                            ),
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(categories.length, (index) {
                      return RowContainer(
                        title: categories[index],
                        isSelected: selectedIndex == index,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      );
                    }),
                  ),
                ),
                SizedBox(height: 15.h),

                // --- Stats Widgets ---
                Row(
                  children: [
                    const Expanded(
                      child: TotalClaimedWidget(
                        title: "Pending Claims",
                        amount: "\$1,240.50",
                        amountColor: Color(0xffFFB547),
                      ),
                    ),
                    SizedBox(width: 12),
                    const Expanded(
                      child: TotalClaimedWidget(
                        title: "Settled This Week",
                        amount: "\$4,892.00",
                        amountColor: Color(0xff33D17A),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),

                SectionHeader(title: 'Recent Activity'),
                SizedBox(height: 16.h),

                CustomJobCard(
                  title: "Walmart DC Shelbyville. TN",
                  dateTime: "Oct 24, 2026 • 08:30 AM",
                  amount: "\$135",
                  amountColor: Colors.greenAccent,
                  statusText: "PAID",
                  statusTextColor: Colors.greenAccent,
                  statusBgColor: Colors.greenAccent.withOpacity(0.1),
                  iconColor: Colors.blueAccent,
                  // onTap: () {
                  //   setState(() {
                  //     isAmazonSelected = (isAmazonSelected == 0) ? -1 : 0;
                  //   });
                  // },
                ),

                CustomJobCard(
                  title: "Amazon Distribution DC4",
                  dateTime: "Oct 23, 2026 • 11:45 AM",
                  amount: "\$225",
                  amountColor: Colors.orangeAccent,
                  statusText: "Submitted",
                  statusTextColor: Colors.orangeAccent,
                  statusBgColor: Colors.orangeAccent.withOpacity(0.1),
                  iconColor: Colors.orangeAccent,
                  // onTap: () {
                  //   setState(() {
                  //     isAmazonSelected = (isAmazonSelected == 1) ? -1 : 1;
                  //   });
                  // },
                ),

                // --- Job Card 3 (Cold Storage) ---
                CustomJobCard(
                  title: "Cold Storage Solutions",
                  dateTime: "Oct 22, 2026 • 11:45 AM",
                  amount: "\$220",
                  amountColor: Colors.redAccent,
                  statusText: "Denied",
                  statusTextColor: Colors.redAccent,
                  statusBgColor: Colors.redAccent.withOpacity(0.1),
                  iconColor: Colors.blueAccent,
                  // onTap: () {
                  //   setState(() {
                  //     isAmazonSelected = (isAmazonSelected == 2) ? -1 : 2;
                  //   });
                  // },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/presentation/profile/view/widget/row_container.dart';
import 'package:lukethompson/presentation/reports/view/widget/claimed_widget.dart';

class MyClaimScreen extends StatefulWidget { 
  const MyClaimScreen({super.key});

  @override
  State<MyClaimScreen> createState() => _MyClaimScreenState();
}

class _MyClaimScreenState extends State<MyClaimScreen> {

  int selectedIndex = 0;

 
  final List<String> categories = [
    "All(12)",
    "Submitted (4)",
    "Draft (2)",
    "Paid",
    "Rejected"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [ColorManager.secondary, ColorManager.primary],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              children: [
                    Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Set Your Rate",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Text(
                          "Track every detention claim you've filed",
                          style: TextStyle(
                            color: Color(0xff8DA2B8),
                            fontSize: 12.sp,
                          
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15.h,),
               Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
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
                      SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          decoration: InputDecoration(
                            hintText: "Search Stops or ID...",
                            hintStyle: TextStyle(
                              color: Colors.grey.withOpacity(0.6),
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
                SizedBox(height: 15.h,),
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
                SizedBox(height: 15.h,),
                Row(
                  children: [
                    Expanded(
                      child: TotalClaimedWidget (
                                    title: "Pending Claims",
                                    amount: "\$1,240.50",
                                    amountColor: Color(0xffFFB547),
                                  ),
                    ),
            SizedBox(width: 10.w,),
                    Expanded(
                      child: TotalClaimedWidget (
                                    title: "Settled This Week",
                                    amount: "\$4,892.00",
                                    amountColor: Color(0xff33D17A),
                                  ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
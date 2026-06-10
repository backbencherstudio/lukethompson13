import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/core/widgets/global_button.dart';

class ClientReview extends StatefulWidget {
  const ClientReview({super.key});

  @override
  State<ClientReview> createState() => _ClientReviewState();
}

class _ClientReviewState extends State<ClientReview> {
  bool isCompanyOpen = false;
  bool isReviewOpen = false;

  String selectedCompany = "Select a company";
  String selectedReview = "Good Payer (80%+ pay rate)";

  final List<String> companyList = ["Google", "Microsoft", "Amazon", "Meta"];
  final List<String> reviewList = [
    "Good Payer (80%+ pay rate)",
    "Mixed Payer (50-70%+ pay rate)",
    "Poor Payer (Under 70%+ pay rate)",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorManager.secondary, ColorManager.primary],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                          size: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      "Client Review",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                Center(
                  child: Image.asset(
                    IconManager.clientReviewIcon,
                    fit: BoxFit.contain,
                    height: 80.h,
                    width: 80.w,
                  ),
                ),

                SizedBox(height: 35.h),

                Text(
                  "Select Company",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () => setState(() {
                    isCompanyOpen = !isCompanyOpen;
                    isReviewOpen = false;
                  }),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedCompany,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                        Icon(
                          isCompanyOpen
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.white38,
                          size: 22.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                if (isCompanyOpen)
                  Container(
                    margin: EdgeInsets.only(top: 8.h),
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161A20),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      children: companyList.map((item) {
                        bool isSelected = selectedCompany == item;
                        return GestureDetector(
                          onTap: () => setState(() {
                            selectedCompany = item;
                            isCompanyOpen = false;
                          }),
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 5.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF34D399)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              item,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white54,
                                fontSize: 14.sp,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                SizedBox(height: 25.h),

                Text(
                  "Share your review",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () => setState(() {
                    isReviewOpen = !isReviewOpen;
                    isCompanyOpen = false;
                  }),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedReview,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                        Icon(
                          isReviewOpen
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.white38,
                          size: 22.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                if (isReviewOpen)
                  Container(
                    margin: EdgeInsets.only(top: 8.h),
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161A20),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      children: reviewList.map((item) {
                        bool isSelected = selectedReview == item;
                        return GestureDetector(
                          onTap: () => setState(() {
                            selectedReview = item;
                            isReviewOpen = false;
                          }),
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 5.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF34D399)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              item,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white54,
                                fontSize: 14.sp,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                SizedBox(height: 50.h),

                GlobalButton(
                  label: "Submit",
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.reviewSubmitted);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


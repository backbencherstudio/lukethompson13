import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class RateShipper extends StatefulWidget {
  const RateShipper({super.key});

  @override
  State<RateShipper> createState() => _RateShipperState();
}

class _RateShipperState extends State<RateShipper> {
  bool isCompanyOpen = false;
  bool isReviewOpen = false;

  String? selectedCompany;
  String? selectedReview;

  final List<String> companyList = ["Google", "Microsoft", "Amazon", "Meta"];
  final List<String> reviewList = [
    "Good Payer (80%+ pay rate)",
    "Mixed Payer (50-70%+ pay rate)",
    "Poor Payer (Under 70%+ pay rate)",
  ];

  @override
  Widget build(BuildContext context) {
    return AppGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GlobalAppBar(title: 'Client Review'),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),

                        Center(
                          child: Image.asset(
                            IconManager.clientReviewIcon,
                            fit: BoxFit.contain,
                            height: 80.h,
                            width: 80.w,
                          ),
                        ),

                        SizedBox(height: 35.h),

                        InputLabel('Select Company'),
                        SizedBox(height: 8.h),
                        DropdownButtonFormField<String?>(
                          initialValue: selectedCompany,
                          hint: Text(
                            "Select a company",
                            style: getRegular400Style12(
                              color: ColorManager.hintTextColor,
                              fontSize: 16,
                            ),
                          ),
                          // hint: ,
                          dropdownColor: ColorManager.tabBarBgColor,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white38,
                            size: 22.sp,
                          ),
                          items: companyList.map((item) {
                            return DropdownMenuItem<String?>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => selectedCompany = value);
                          },
                        ),

                        SizedBox(height: 15.h),
                        InputLabel('Share your review'),
                        SizedBox(height: 8.h),
                        DropdownButtonFormField<String?>(
                          initialValue: selectedReview,
                          hint: Text(
                            "Share your review",
                            style: getRegular400Style12(
                              color: ColorManager.hintTextColor,
                              fontSize: 16,
                            ),
                          ),
                          // hint: ,
                          dropdownColor: ColorManager.tabBarBgColor,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white38,
                            size: 22.sp,
                          ),
                          items: reviewList.map((item) {
                            return DropdownMenuItem<String?>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => selectedCompany = value);
                          },
                        ),

                        const Spacer(),

                        GlobalButton(
                          label: "Submit",
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.reviewSubmitted,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

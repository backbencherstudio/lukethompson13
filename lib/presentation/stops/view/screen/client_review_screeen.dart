import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class RateShipperScreen extends StatefulWidget {
  const RateShipperScreen({super.key});

  @override
  State<RateShipperScreen> createState() => _RateShipperScreenState();
}

class _RateShipperScreenState extends State<RateShipperScreen> {
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
          child: FullHeightScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                Center(
                  child: Assets.icons.clientReviewLogo.image(height: 80.w),
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
                    setState(() => selectedReview = value);
                  },
                ),

                const Spacer(),

                GlobalButton(
                  label: "Submit",
                  onPressed: () {
                    context.push(Routes.reviewSubmitted);
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

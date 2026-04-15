import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/detention_widget.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8.r),
      child: Column(
        children: [
               SizedBox(height: 15.h,),
               Row(
                 children: [
      
                   Expanded(
                     child: DetentionWidget(
                      imagePath: IconManager.detention,
                      title: "Detention Owed",
                      price: "\$225",
                      rate: "\$50/hr rate",
                      
                     ),
                   ),
                   SizedBox(width: 5.w,),
                   Expanded(
                     child: DetentionWidget(
                      imagePath: IconManager.revenueLost,
                      title: "Revenue Lost",
                      price: "\$225",
                      rate: "Unrecovered time costs",
                      priceColor: ColorManager.redColor,
                      
                     ),
                   ),
                 ],
               )
        ],
      ),
    );
  }
}
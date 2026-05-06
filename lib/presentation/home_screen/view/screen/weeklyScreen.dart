import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/detention_widget.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/wrostStop_widget.dart';

class Weeklyscreen extends StatelessWidget {
  const Weeklyscreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(//
        padding:  EdgeInsets.all(8.r),
        child: Column(
          children: [
            SizedBox(height: 15.h),
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
                SizedBox(width: 5.w),
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
            ),
            SizedBox(height: 15.h,),
            const WroststopWidget(),
            //
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(width: 1.w,color:  ColorManager.backgroundColorgreen1.withValues(alpha: .2),),
                color: Color(0XFF202227),

              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(IconManager.clock,width: 24.w,height: 24.h,),
                        SizedBox(width: 8.w,),
                        Text("Hours Tracked",style: TextStyle(
                          fontSize: 16.sp,color: ColorManager.textColor,fontWeight: FontWeight.w700
                        ),)
                      ],
                    ),
                    SizedBox(height: 15.h,),
                    Text("3h",style: TextStyle(fontSize: 32.sp,color: ColorManager.primaryButton,fontWeight: FontWeight.w700),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 50.h,)
            
          ],
        ),
      ),
    );
  }
}
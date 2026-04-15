import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';

class WroststopWidget extends StatelessWidget {
  const WroststopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(width: 1.5.w,color: Colors.red.withValues(alpha: .3)),
        color: ColorManager.redColor.withValues(alpha: .2),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(IconManager.worst,width: 24.w,height: 24.h,),
                SizedBox(width: 10.w,),
                Text("Worst Stop",style: TextStyle(
                  color: Colors.red,fontSize: 16.sp,fontWeight: FontWeight.w700
                ),)
              ],
            ),
            SizedBox(height: 20.h,),
            Text("Warehouse A",style: TextStyle(color: ColorManager.whiteColor,fontSize: 16.sp),),
            SizedBox(height: 5.h,),
            Text("\$250 lost",style: TextStyle(fontSize: 32.sp,fontWeight: FontWeight.w700,color: Colors.red),)
          ],
        ),
      ),
    );
  }
}
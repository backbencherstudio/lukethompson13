import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class FollowUp extends StatelessWidget {
  const FollowUp({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Tomar deya Header part (Unchanged)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
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
                            "Follow-up Timeline",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.h,),
                          Text(
                            "Walmart DC • \$135 • 16 days unpaid",
                            style: TextStyle(
                              color: const Color(0xff8DA2B8),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

            
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                      gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [ColorManager.secondary, Color(0XFF1E222C)],
          ),
                     
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: const Color(0xFF00C853), width: 1.5),
                           gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomRight,
            colors: [ColorManager.secondary, ColorManager.primary],
          ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Claim Amount", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color:  Color(0xFF2D1619).withValues(alpha: .2),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text("Unpaid", style: TextStyle(color:  Color(0xFFE57373), fontSize: 12.sp, fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text("\$225.00", style: TextStyle(color: const Color(0xFF00FF88), fontSize: 32.sp, fontWeight: FontWeight.bold)),
                              SizedBox(height: 16.h),
                              Divider(color: Colors.white.withOpacity(0.1)),
                              SizedBox(height: 16.h),
                              Row(
                                children: [
                                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text("Sent", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 12.sp)),
                                    Text("Apr 8, 2026", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                                  ])),
                                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text("Via", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 12.sp)),
                                    Text("Email", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                                  ])),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                children: [
                                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text("Broker CC", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 12.sp)),
                                    Text("billing@walmart", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                                  ])),
                                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text("Broker CC", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 12.sp)),
                                    Text("billing@walmart", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                                  ])),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),
                        Text("Follow-up Timeline", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16.h),

                        // --- Timeline Container ---
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF11171D),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            children: [
                              // Timeline Item 1
                              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Padding(padding: EdgeInsets.only(top: 4.h), child: Icon(Icons.circle, color: const Color(0xFF00FF88), size: 10.r)),
                                SizedBox(width: 12.w),
                                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text("Follow-up sent - Professional Reminder", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500)),
                                  SizedBox(height: 4.h),
                                  // Overflow fix with SingleChildScrollView or Wrap
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(children: [
                                      Text("• Apr 15, 2026 ", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 11.sp)),
                                      Text("• 9:14 AM ", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 11.sp)),
                                      Text("• Email + Broker CC", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 11.sp)),
                                    ]),
                                  ),
                                ])),
                              ]),
                              Divider(color: Colors.white12, height: 32.h),

                              // Timeline Item 2
                              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Padding(padding: EdgeInsets.only(top: 4.h), child: Icon(Icons.circle, color: const Color(0xFF00FF88), size: 10.r)),
                                SizedBox(width: 12.w),
                                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text("Claim submitted to dispatch@tql.com", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500)),
                                  SizedBox(height: 4.h),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    Text("• Apr 8, 2026  • 2:31 PM", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 11.sp)),
                                    Text("• Email", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 11.sp)),
                                  ]),
                                ])),
                              ]),
                              Divider(color: Colors.white12, height: 32.h),

                              // Timeline Item 3
                              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Padding(padding: EdgeInsets.only(top: 4.h), child: Icon(Icons.circle, color: const Color(0xFF00FF88), size: 10.r)),
                                SizedBox(width: 12.w),
                                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text("Stop logged — 4h 15m total wait", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500)),
                                  SizedBox(height: 4.h),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    Text("• Apr 7, 2026  • 1:30 PM", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 11.sp)),
                                    Text("• GPS verified", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 11.sp)),
                                  ]),
                                ])),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
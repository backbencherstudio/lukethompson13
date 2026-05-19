import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class ClaimDetail extends StatefulWidget {
  const ClaimDetail({super.key});

  @override
  State<ClaimDetail> createState() => _ClaimDetailState();
}

class _ClaimDetailState extends State<ClaimDetail> {
  
  int activeIndex = 1; 

  final List<Map<String, String?>> timelineSteps = [
    {"title": "Soft follow-ups", "day": "Day 2, 7, 14", "btn": "Send Follow-up"},
    {"title": "Broker Formal Escalation", "day": "Day 15+", "btn": "Send Generate Email"},
    {"title": "Certified Demand Letter", "day": "Day 21+", "btn": "Send Demand Letter"},
    {"title": "Broker Bond Claim (BMC-84/85)", "day": "Day 21+", "btn": "Submit Bond Claim"},
    {"title": "Credit Bureau Report", "day": "Day 30+", "btn": "Report to Bureau"},
    {"title": "FMCSA Complaint", "day": "Day 30+", "btn": "File Complaint"},
    {"title": "Load Board Negative Report", "day": "Day 30+", "btn": "Submit Report"},
    {"title": "Small Claims Court Filing", "day": "Day 45+", "btn": "Start Filing"},
    {"title": "Collections / Attorney Referral", "day": "Day 60+", "btn": "Refer to Attorney"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [ColorManager.secondary, ColorManager.primary],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
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
                        child: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("My Claim", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600)),
                        SizedBox(height: 5.h),
                        Text("Track every detention claim you've filed", style: TextStyle(color: const Color(0xff8DA2B8), fontSize: 12.sp)),
                      ],
                    ),
                  ],
                ),
              ),

            
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111821).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: const Color(0xFF22C55E).withOpacity(0.5)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Claim Amount", style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold)),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                  decoration: BoxDecoration(color: const Color(0xFF3B1E1E), borderRadius: BorderRadius.circular(10.r)),
                                  child: Text("Unpaid", style: TextStyle(color: const Color(0xFFEF4444), fontSize: 10.sp, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Text("\$225.00", style: TextStyle(color: const Color(0xFF22C55E), fontSize: 32.sp, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                      SizedBox(height: 25.h),
                      Text("FOLLOW-UP", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10.h),

                      Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: const Color(0xFF161B22).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          children: List.generate(timelineSteps.length, (index) {
                            bool isCompleted = index < activeIndex;
                            bool isActive = index == activeIndex;

                            return IntrinsicHeight(
                              child: Row(
                                children: [
                          
                                  Column(
                                    children: [
                             
                                      Container(
                                        width: 28.r, height: 28.r,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isCompleted || isActive ? const Color(0xFF22C55E).withOpacity(0.15) : Colors.transparent,
                                        ),
                                        padding: EdgeInsets.all(isCompleted ? 5.r : 0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isCompleted || isActive ? const Color(0xFF22C55E) : Colors.white.withOpacity(0.05),
                                            border: isCompleted || isActive ? null : Border.all(color: Colors.white12),
                                          ),
                                          child: isCompleted
                                              ? Icon(Icons.check, color: Colors.white, size: 12.sp)
                                              : Text("0${index + 1}", style: TextStyle(color: isActive ? Colors.white : Colors.white38, fontSize: 11.sp, fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                               
                                      if (index != timelineSteps.length - 1)
                                        Expanded(
                                          child: Container(
                                            width: 1.5,
                                            color: isCompleted ? const Color(0xFF22C55E) : Colors.white12,
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(width: 15.w),

                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 25.h),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            timelineSteps[index]["title"]!,
                                            style: TextStyle(
                                              color: isActive ? const Color(0xFF22C55E) : (isCompleted ? Colors.white : Colors.white54),
                                              fontSize: 14.sp, fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(timelineSteps[index]["day"]!, style: TextStyle(color: Colors.white38, fontSize: 11.sp)),
                                          
                                          
                                          if (isActive)
                                            Padding(
                                              padding: EdgeInsets.only(top: 12.h),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (activeIndex < timelineSteps.length) {
                                                      activeIndex++;
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20.r),
                                                    border: Border.all(color: const Color(0xFF22C55E).withOpacity(0.6)),
                                                  ),
                                                  child: Text(
                                                    timelineSteps[index]["btn"]!,
                                                    style: TextStyle(color: const Color(0xFF22C55E), fontSize: 12.sp, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
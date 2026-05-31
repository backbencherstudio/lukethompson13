import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';

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
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
                        child: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("My Claim", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600)),
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
                              children:
                               [
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
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text("Sent", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 11.sp)),
                                  Text("Apr 8, 2026", style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold)),
                                ])),
                                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text("Via", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 11.sp)),
                                  Text("Email", style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold)),
                                ])),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text("Broker CC", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 11.sp)),
                                  Text("billing@walmart", style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold)),
                                ])),
                                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text("Broker CC", style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 11.sp)),
                                  Text("billing@walmart", style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold)),
                                ])),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 25.h),
                      Text("PROOF PACKAGE", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                      SizedBox(height: 10.h),

                      // --- 3. PROOF PACKAGE CARD ---
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF161B22).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Column(
                          children: ["BOL Photo-bol_photo.jpg", "GPS Proof — auto-captured", "Time Calculations PDF", "Proof Package PDF"]
                              .asMap().entries.map((item) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(item.value, style: TextStyle(color: const Color(0xFF8DA2B8), fontSize: 11.sp)),
                                      Icon(Icons.check, color: const Color(0xFF22C55E), size: 18.sp),
                                    ],
                                  ),
                                ),
                                if (item.key != 3) const Divider(color: Colors.white12, height: 1),
                              ],
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(height: 25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("FOLLOW-UP", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold)),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesName.followUp);
                            },
                            child: Text("See Timeline", style: TextStyle(color: const Color(0xFF22C55E), fontSize: 13.sp, fontWeight: FontWeight.w500))),
                        ],
                      ),
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
                                        width: 32.r, height: 32.r,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isCompleted || isActive ? const Color(0xFF22C55E).withOpacity(0.15) : Colors.transparent,
                                        ),
                                        padding: EdgeInsets.all(isCompleted ? 3.r : 0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isCompleted || isActive ? const Color(0xFF22C55E) : Colors.white.withOpacity(0.05),
                                            border: isCompleted || isActive ? null : Border.all(color: Colors.white12),
                                          ),
                                          child: isCompleted
                                              ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                                              : Text("0${index + 1}", style: TextStyle(color: isActive ? Colors.white : Colors.white38, fontSize: 11.sp, fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      if (index != timelineSteps.length - 1)
                                        Expanded(child: Container(width: 1.5, color: isCompleted ? const Color(0xFF22C55E) : Colors.white12)),
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
                                          if (isActive && index >= 1) 
                                            Padding(
                                              padding: EdgeInsets.only(top: 12.h),
                                              child: GestureDetector(
                                                onTap: () => setState(() => activeIndex++),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: const Color(0xFF22C55E).withOpacity(0.6))),
                                                  child: Text(timelineSteps[index]["btn"]!, style: TextStyle(color: const Color(0xFF22C55E), fontSize: 12.sp, fontWeight: FontWeight.bold)),
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
          
                      Container(
                        width: double.infinity, height: 50.h,
                        decoration: BoxDecoration(color: const Color(0xFF22C55E), borderRadius: BorderRadius.circular(25.r)),
                        child: Center(child: Text("Mark Paid - Done", style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.bold))),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        width: double.infinity, height: 50.h,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r), border: Border.all(color: Colors.white24)),
                        child: Center(child: Text("Mark Uncollectable", style: TextStyle(color: Colors.white54, fontSize: 15.sp, fontWeight: FontWeight.bold))),
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
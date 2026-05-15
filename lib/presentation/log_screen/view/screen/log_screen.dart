import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  // কনফার্মেশন ট্র্যাকিং ভেরিয়েবল
  bool isDockInConfirmed = false;
  bool isCompletedConfirmed = false;
  bool isDepartureConfirmed = false;
  bool isGpsEnabled = true;

  final TextEditingController facilityController = TextEditingController(text: 'Walmart DC - Memphis, TN');
  final TextEditingController dockInController = TextEditingController(text: '08:15 AM');
  final TextEditingController completedController = TextEditingController(text: '12:45 AM');
  final TextEditingController departureController = TextEditingController(text: '01:00 PM');

  @override
  void dispose() {
    facilityController.dispose();
    dockInController.dispose();
    completedController.dispose();
    departureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
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
              // --- Custom Header (Same as original) ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Log Stop", style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.bold)),
                        Text("Review details before sending", style: TextStyle(color: Colors.grey.shade500, fontSize: 13.sp)),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      // --- GPS Switch (Same as original) ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("GPS for Log Stop", style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600)),
                          GestureDetector(
                            onTap: () => setState(() => isGpsEnabled = !isGpsEnabled),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: 36.w,
                              height: 18.h,
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              decoration: BoxDecoration(
                                color: isGpsEnabled ? const Color(0xFF32D583) : const Color(0xFF3B4752),
                                borderRadius: BorderRadius.circular(999.r),
                              ),
                              alignment: isGpsEnabled ? Alignment.centerRight : Alignment.centerLeft,
                              child: Container(
                                width: 16.w,
                                height: 16.w,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      // --- Facility Name & Warning (Same as original) ---
                      Text("FACILITY NAME", style: TextStyle(color: Colors.grey.shade400, fontSize: 12.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8.h),
                      Container(
                        height: 38.h,
                        decoration: BoxDecoration(color: const Color(0xFF1E222C), borderRadius: BorderRadius.circular(6.r)),
                        child: TextField(
                          controller: facilityController,
                          style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: const Color(0xFF1E222C),
                            hintText: 'Facility name',
                            hintStyle: TextStyle(color: const Color(0xFF8B95A1), fontSize: 12.sp),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 11.h),
                            prefixIcon: Icon(Icons.search, color: const Color(0xFF8B95A1), size: 18.sp),
                            prefixIconConstraints: BoxConstraints(minWidth: 36.w),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1217),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.red.withOpacity(0.3)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Heads up - Amazon FC Dallas", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 14.sp)),
                                  SizedBox(height: 4.h),
                                  Text("8 GetDockPay drivers reported slow or no payment here. Attach your BOL and document everything.", style: TextStyle(color: Colors.grey.shade400, fontSize: 12.sp)),
                                ],
                              ),
                            ),
                            const Icon(Icons.close, color: Colors.grey, size: 18),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h),

                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                _buildTimelineDot(isActive: true),
                                Container(
                                  width: 2.w,
                                  height: 64.h,
                                  color: const Color(0xFF2ECC71),
                                ),
                              ],
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Arrival Time',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  _buildStaticTimeField('08:00 AM'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildEditableTimelineItem(
                        title: 'Dock In Time',
                        controller: dockInController,
                        isConfirmed: isDockInConfirmed,
                        isEnabled: true,
                        showConnector: true,
                        nextStepConfirmed: isCompletedConfirmed,
                        onConfirm: () {
                          if (dockInController.text.trim().isNotEmpty) {
                            setState(() => isDockInConfirmed = true);
                          }
                        },
                      ),
                      _buildEditableTimelineItem(
                        title: 'Completed Time',
                        controller: completedController,
                        isConfirmed: isCompletedConfirmed,
                        isEnabled: isDockInConfirmed,
                        showConnector: true,
                        nextStepConfirmed: isDepartureConfirmed,
                        onConfirm: () {
                          if (isDockInConfirmed && completedController.text.trim().isNotEmpty) {
                            setState(() => isCompletedConfirmed = true);
                          }
                        },
                      ),
                      _buildEditableTimelineItem(
                        title: 'Departure Time',
                        controller: departureController,
                        isConfirmed: isDepartureConfirmed,
                        isEnabled: isCompletedConfirmed,
                        showConnector: false,
                        nextStepConfirmed: false,
                        onConfirm: () {
                          if (isCompletedConfirmed && departureController.text.trim().isNotEmpty) {
                            setState(() => isDepartureConfirmed = true);
                          }
                        },
                      ),

                      SizedBox(height: 25.h),
                 
                      Text("Attachments", style: TextStyle(color: const Color.fromARGB(255, 214, 213, 213), fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.h),
                      DottedBorder(
                        color: const Color(0xFF2D343C),
                        strokeWidth: 1.5,
                        dashPattern: const [6, 4],
                        borderType: BorderType.RRect,
                        radius: Radius.circular(15.r),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          decoration: BoxDecoration(color: const Color(0xFF111821), borderRadius: BorderRadius.circular(15.r)),
                          child: Column(
                            children: [
                              Container(height: 45.w, width: 45.w, decoration: const BoxDecoration(color: Color(0xFF0F2623), shape: BoxShape.circle), child: const Icon(Icons.cloud_upload, color: Color(0xFF00C853), size: 24)),
                              SizedBox(height: 12.h),
                              Text("Tap to upload photo", style: TextStyle(color: const Color(0xFF00C853), fontSize: 14.sp, fontWeight: FontWeight.w600)),
                              SizedBox(height: 4.h),
                              Text("PNG, JPG or PDF (max. 800x400px)", style: TextStyle(color: const Color(0xFF6C757D), fontSize: 12.sp)),
                              SizedBox(height: 15.h),
                              Row(
                                children: [
                                  Expanded(child: Divider(color: const Color(0xFF2D343C), indent: 40.w, endIndent: 10.w)),
                                  Text("or", style: TextStyle(color: const Color(0xFF6C757D), fontSize: 12.sp)),
                                  Expanded(child: Divider(color: const Color(0xFF2D343C), indent: 10.w, endIndent: 40.w)),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: const Color(0xFF00C853), width: 1)),
                                child: Text("Open Camera", style: TextStyle(color: const Color(0xFF00C853), fontSize: 14.sp, fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        color: const Color(0xFF0F1419),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2ECC71),
            minimumSize: Size(double.infinity, 54.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
          ),
          child: Text("Calculate & Preview", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildEditableTimelineItem({
    required String title,
    required TextEditingController controller,
    required bool isConfirmed,
    required bool isEnabled,
    required bool showConnector,
    required bool nextStepConfirmed,
    required VoidCallback onConfirm,
  }) {
    final Color activeColor = const Color(0xFF2ECC71);
    final Color disabledTextColor = const Color(0xFF5B6773);

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 18.w,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: _buildTimelineDot(isActive: true),
                ),
                if (showConnector)
                  Container(
                    width: 2.w,
                    height: 64.h,
                    color: activeColor,
                  ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isEnabled || isConfirmed ? Colors.white.withOpacity(0.88) : disabledTextColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 42.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E222C),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: TextField(
                          controller: controller,
                          enabled: isEnabled && !isConfirmed,
                          style: TextStyle(
                            color: isEnabled || isConfirmed ? Colors.white: disabledTextColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: const Color(0xFF1E222C),
                            hintText: controller.text,
                            hintStyle: TextStyle(color: disabledTextColor, fontSize: 13.sp),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
                            suffixIcon: Icon(
                              Icons.access_time,
                              size: 16.sp,
                              color: isEnabled || isConfirmed ? Colors.white70 : disabledTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: isConfirmed ? null : onConfirm,
                      child: Container(
                        height: 42.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: isConfirmed || isEnabled ? activeColor : const Color(0xFF1A2028),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            color: isConfirmed || isEnabled ? Colors.white : const Color(0xFF17754B),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineDot({required bool isActive}) {
    final Color color = isActive ? const Color(0xFF2ECC71) : const Color(0xFF738091);

    return Container(
      width: 16.w,
      height: 16.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.2),
      ),
      child: isActive
          ? Icon(
              Icons.check,
              size: 10.sp,
              color: color,
            )
          : null,
    );
  }

  Widget _buildStaticTimeField(String value) {
    return Container(
      height: 42.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1E222C),
        borderRadius: BorderRadius.circular(6.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(Icons.access_time, size: 16.sp, color: Colors.white70),
        ],
      ),
    );
  }
}

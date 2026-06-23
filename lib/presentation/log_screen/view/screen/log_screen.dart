import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/app_switch.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';
import 'package:lukethompson/presentation/log_screen/view/widget/attachment_upload_section.dart';
import 'package:lukethompson/presentation/log_screen/view/widget/info_banner.dart';
import 'package:lukethompson/presentation/log_screen/view/widget/timeline_item.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  bool isDockInConfirmed = false;
  bool isCompletedConfirmed = false;
  bool isDepartureConfirmed = false;
  bool isGpsEnabled = true;
  bool isDockInEdited = false;
  bool isCompletedEdited = false;
  bool isDepartureEdited = false;

  var arrivalStatus = TimelineItemStatus.completed;
  var docInStatus = TimelineItemStatus.active;
  var completedStatus = TimelineItemStatus.idle;
  var departureStatus = TimelineItemStatus.idle;

  static const String _initialArrivalTime = '08:15 AM';
  static const String _initialDockInTime = '08:15 AM';
  static const String _initialCompletedTime = '12:45 AM';
  static const String _initialDepartureTime = '01:00 PM';

  final TextEditingController facilityController = TextEditingController(
    text: 'Walmart DC - Memphis, TN',
  );
  final TextEditingController dockInController = TextEditingController(
    text: _initialDockInTime,
  );
  final TextEditingController completedController = TextEditingController(
    text: _initialCompletedTime,
  );
  final TextEditingController departureController = TextEditingController(
    text: _initialDepartureTime,
  );

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
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF0F1419),
      appBar: GlobalAppBar(
        hideBackButton: true,
        title: 'Log Stop',
        subTitle: "Review details before sending",
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                // --- GPS Switch (Same as original) ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "GPS for Log Stop",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppSwitch(
                      value: isGpsEnabled,
                      onChanged: (value) {
                        setState(() => isGpsEnabled = value);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // --- Facility Name ---
                Text("FACILITY NAME", style: context.labelLarge),
                SizedBox(height: 8.h),
                const SearchBarWidget(hintText: "Search facilities..."),
                SizedBox(height: 15.h),
                InfoBanner(
                  icon: Icons.warning_amber_rounded,
                  title: "Heads up - Amazon FC Dallas",
                  content:
                      "8 GetDockPay drivers reported slow or no payment here. Attach your BOL and document everything.",
                  titleColor: ColorManager.errorColor,
                ),
                SizedBox(height: 24.h),
                TimelineItem(
                  title: 'Arrival Time',
                  status: arrivalStatus,
                  controller: dockInController,
                  onChanged: (value) {
                    setState(() {
                      isDockInEdited =
                          value.trim().isNotEmpty &&
                          value != _initialDockInTime;
                    });
                  },
                ),
                TimelineItem(
                  title: 'Dock In Time',
                  status: docInStatus,
                  controller: dockInController,
                  onChanged: (value) {
                    setState(() {
                      isDockInEdited =
                          value.trim().isNotEmpty &&
                          value != _initialDockInTime;
                    });
                  },
                  onConfirm: () {
                    if (dockInController.text.trim().isNotEmpty) {
                      setState(() => isDockInConfirmed = true);
                    }
                  },
                ),
                TimelineItem(
                  title: 'Completed Time',
                  status: completedStatus,
                  controller: completedController,
                  onChanged: (value) {
                    setState(() {
                      isCompletedEdited =
                          value.trim().isNotEmpty &&
                          value != _initialCompletedTime;
                    });
                  },
                  onConfirm: () {
                    if (isDockInConfirmed &&
                        completedController.text.trim().isNotEmpty) {
                      setState(() => isCompletedConfirmed = true);
                    }
                  },
                ),
                TimelineItem(
                  title: 'Departure Time',
                  status: departureStatus,
                  controller: departureController,
                  isLastStep: true,
                  onChanged: (value) {
                    setState(() {
                      isDepartureEdited =
                          value.trim().isNotEmpty &&
                          value != _initialDepartureTime;
                    });
                  },
                  onConfirm: () {
                    if (isCompletedConfirmed &&
                        departureController.text.trim().isNotEmpty) {
                      setState(() => isDepartureConfirmed = true);
                    }
                  },
                ),

                SizedBox(height: 24.h),

                const AttachmentUploadSection(),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppPadding.screenPadding),
        color: const Color(0xFF0F1419),
        child: GlobalButton(label: "Calculate & Preview", onPressed: () {}),
      ),
    );
  }
}

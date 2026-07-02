import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/attachment_upload_section.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/facility_section.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/timeline_section.dart';

class CreateStopLogScreen extends StatelessWidget {
  const CreateStopLogScreen({super.key});

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
            padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                const FacilitySection(),

                SizedBox(height: 24.h),
                const TimelineSection(),

                SizedBox(height: 24.h),
                const AttachmentUploadSection(),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(AppPadding.screenPadding),
        child: GlobalButton(
          label: "Calculate & Preview",
          onPressed: () {
            context.push(Routes.logStopResult);
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/datetime_extension.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/utils/date.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/core/widgets/app_text_logo.dart';
import 'package:lukethompson/core/widgets/attachment_image_viewer.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/breakdown_card.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/proof_package_list.dart';

class FullClaimPreviewCard extends StatelessWidget {
  final SingleStoplogDetailData? data;

  const FullClaimPreviewCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppIconHorizontal(),
          SizedBox(height: 16.h),

          DetensionInfoBannder(data: data),

          16.height,
          InputLabel('CLAIM DETAILS'),
          8.height,
          BreakdownCard(
            color: ColorManager.surfaceBacground,
            borderColor: ColorManager.cardBackground,
            items: [
              BreakdownItem(label: 'Facility', value: data?.facilityName ?? ""),
              BreakdownItem(
                label: "Arrival - Departure",
                value:
                    "${data?.arrivedAt?.formatTime()} -> ${data?.departedAt?.formatTime()}",
              ),
              BreakdownItem(
                label: "Billable Detention",
                value: data?.billableTimeText ?? '-',
                valueColor: ColorManager.primaryButton,
              ),
              BreakdownItem(label: "BOL Number", value: data?.bolNumber ?? "-"),
              BreakdownItem(
                label: "GPS Coordinates",
                value: data?.gpsCoordinates ?? '-',
                valueColor: ColorManager.infoColor,
              ),
            ],
          ),

          16.height,
          InputLabel('PROOF PACKAGE'),
          8.height,
          ProofPackageList(
            onItemPressed: (index) => AttachmentImageViewer.show(
              context,
              attachments: data?.attachments ?? [],
              index: index,
            ),
            fineNames: data?.attachments?.map((e) => e.fileName).toList() ?? [],
          ),
        ],
      ),
    );
  }

  static AsyncValue<SingleStoplogDetailData?> getSession(
    WidgetRef ref,
    String? steplogId,
  ) {
    final session = steplogId != null && steplogId.isNotEmpty
        ? ref.watch(getSingleLogWithId(steplogId))
        : const AsyncValue.data(null);
    return session;
  }
}

class DetensionInfoBannder extends StatelessWidget {
  final SingleStoplogDetailData? data;

  const DetensionInfoBannder({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: .all(12),
      backgroundColor: ColorManager.primaryButton.withValues(alpha: 0.05),
      borderColor: ColorManager.primaryButton.withValues(alpha: 0.7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detention Claim Amount",
            style: TextStyle(color: ColorManager.subtextColor, fontSize: 12.sp),
          ),
          Text(
            CurrencyFormatter.format(data?.detention),
            style: TextStyle(
              color: ColorManager.primaryButton,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${data?.billableTimeText} billable . ${CurrencyFormatter.format(data?.ratePerHour)}/hr detention rate . ${data?.freeWaitTime} free time",
            style: TextStyle(color: ColorManager.subtextColor, fontSize: 11.sp),
          ),
        ],
      ),
    );
  }
}

class AppIconHorizontal extends StatelessWidget {
  const AppIconHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          IconManager.appLogo,
          fit: BoxFit.cover,
          height: 38.h,
          width: 42.w,
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextLogo(),
            SizedBox(height: 2.h),
            Text(
              "Review details before sending",
              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            ),
          ],
        ),
      ],
    );
  }
}

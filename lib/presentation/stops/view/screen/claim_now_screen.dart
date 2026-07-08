import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/datetime_extension.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/providers/stoplog_queries.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/ClaimSendTo.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/breakdown_card.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/proof_package_list.dart';

class ClaimNowScreenArg {
  const ClaimNowScreenArg({
    this.steplogId,
    this.facilityName,
    this.shipperFacilityId,
  });

  final String? steplogId;
  final String? facilityName;
  final String? shipperFacilityId;
}

class ClaimNowScreen extends ConsumerWidget {
  const ClaimNowScreen({super.key, this.argument});

  final ClaimNowScreenArg? argument;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session =
        argument?.steplogId != null && argument!.steplogId!.isNotEmpty
        ? ref.watch(getSingleLogWithId(argument!.steplogId!))
        : const AsyncValue.data(null);

    return AppGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: GlobalAppBar(
          title: 'Claim Detail',
          subTitle: argument?.facilityName,
        ),
        body: SafeArea(
          child: session.when(
            skipLoadingOnRefresh: true,
            skipLoadingOnReload: true,
            data: (data) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    16.height,
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppIconHorizontal(),
                          SizedBox(height: 16.h),

                          DetensionInfoBannder(),

                          16.height,
                          InputLabel('CLAIM DETAILS'),
                          8.height,

                          BreakdownCard(
                            color: ColorManager.surfaceBacground,
                            borderColor: ColorManager.cardBackground,
                            items: [
                              BreakdownItem(
                                label: 'Facility',
                                value: data?.facilityName ?? "",
                              ),
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
                              BreakdownItem(
                                label: "BOL Number",
                                value: data?.bolNumber ?? "-",
                              ),
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
                            fineNames:
                                data?.attachments
                                    ?.map((e) => e.fileName)
                                    .toList() ??
                                [],
                          ),
                        ],
                      ),
                    ),

                    16.height,
                    GlobalButton.secondary(
                      label: 'Export PDF',
                      onPressed: () {},
                    ),

                    ClaimSendTo(),
                  ],
                ),
              );
            },
            loading: () => const Center(child: ActivityIndicator()),
            error: (e, st) {
              print(st);
              return StatusDisplay.error(e.toString());
            },
          ),
        ),
      ),
    );
  }
}

class DetensionInfoBannder extends StatelessWidget {
  const DetensionInfoBannder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorManager.primaryButton.withValues(alpha: 0.8),
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: ColorManager.primaryButton.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detention Claim Amount",
            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
          ),
          Text(
            "\$135.00",
            style: TextStyle(
              color: const Color(0xFF32D779),
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "2h 15m billable . \$60/hr detention rate . 2h free time",
            style: TextStyle(color: Colors.grey, fontSize: 11.sp),
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

class AppTextLogo extends StatelessWidget {
  const AppTextLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "GET",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "DOCK",
            style: TextStyle(
              color: const Color(0xFF32D779),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "PAY",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

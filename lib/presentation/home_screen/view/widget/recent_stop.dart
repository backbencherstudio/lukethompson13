import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/utils/date.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/data/models/stops/stop_log_list_response.model.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_badge.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';

class RecentStopData {
  final String title;
  final String subtitle;
  final String amount;

  final String? status;
  final String? icon;
  final String? badge;
  final String? actionLabel;

  const RecentStopData({
    required this.title,
    required this.subtitle,
    required this.amount,
    this.status,
    this.icon = "assets/icons/building.svg",
    this.badge,
    this.actionLabel,
  });
}

// TODO: validate data with the ui
class RecentStop extends StatelessWidget {
  final RecentStopData data;

  final Color? iconColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? amountColor;
  final Color? borderColor;
  final Widget? rightAction;
  final Widget? badge;

  const RecentStop({
    super.key,
    required this.data,

    this.titleColor = Colors.white,
    this.iconColor = const Color(0xFF00A3FF),
    this.subtitleColor = const Color(0XFF8DA2B8),
    this.amountColor = ColorManager.primaryButton,
    this.borderColor,
    this.rightAction,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderColor: borderColor,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: iconColor?.withAlpha(30),
                ),
                child: SvgPicture.asset(
                  data.icon ?? Assets.icons.building,
                  colorFilter: iconColor != null
                      ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                      : null,
                  width: 20.w,
                  height: 20.h,
                ),
              ),
              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data.title,
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (badge != null) ...[SizedBox(width: 8), badge!],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      data.subtitle,
                      style: TextStyle(color: subtitleColor, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.amount,
                style: TextStyle(
                  color: amountColor,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),

              ?rightAction,
            ],
          ),
        ],
      ),
    );
  }

  static final mockrecentStopData = [
    const RecentStopData(
      title: "Walmart DC Shelbyville. TN",
      subtitle: "Thu Apr 24 4h 15m wait 2h 15m billable",
      amount: "\$135",
      status: "Good Payer",
    ),
    const RecentStopData(
      title: "FedEx Memphis Hub",
      subtitle: "Fri Apr 25 3h 30m wait 1h 45m billable",
      amount: "\$98",
      status: "Average Payer",
    ),
    const RecentStopData(
      title: "Amazon Fulfillment Center",
      subtitle: "Mon Apr 28 5h 00m wait 3h 00m billable",
      amount: "\$210",
      status: "Poor Payer",
    ),
    const RecentStopData(
      title: "UPS Louisville Hub",
      subtitle: "Tue Apr 29 2h 45m wait 1h 30m billable",
      amount: "\$75",
      status: "Good Payer",
    ),
  ];
}

class RecentStopList extends StatelessWidget {
  final AsyncValue<List<StopLog>?> value;

  const RecentStopList({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnRefresh: true,
      skipLoadingOnReload: true,
      loading: () => const Center(child: ActivityIndicator()),
      error: (e, _) =>
          StatusDisplay.error('Something went wrong. Please try again.'),
      data: (stops) {
        if (stops == null || stops.isEmpty) {
          return StatusDisplay.muted('No stops found');
        }

        return Column(
          children: stops
              .map(
                (stop) => Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: RecentStop(
                    data: RecentStopData(
                      title: stop.facilityName,
                      subtitle: AppDateUtils.formatDateWithTime(stop.date),
                      amount: Currency.addPrefix(stop.amount),
                      status: stop.status,
                    ),
                    rightAction: StatusBadge(status: stop.status),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

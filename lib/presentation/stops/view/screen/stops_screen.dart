import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/route/routes_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/recent_stop.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_badge.dart';
import 'package:lukethompson/presentation/stops/view/widget/walmart_card_widget.dart';

class StopsScreen extends StatelessWidget {
  const StopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recentStopData = [
      const RecentStopData(
        title: "FedEx Ground Port",
        subtitle: "Oct 21, 2026 • 09:00 AM",
        amount: "\$135",
        actionLabel: 'Claim Now',
        badge: 'No Claim',
      ),
      const RecentStopData(
        title: "Walmart DC Shelbyville. TN",
        subtitle: "Oct 24, 2026 • 08:30 AM",
        amount: "\$135",
        actionLabel: "Rate Shipper",
        badge: 'Paid',
      ),
      const RecentStopData(
        title: "Cold Storage Solutions",
        subtitle: "Oct 22, 2026 • 11:45 AM",
        amount: "\$210",
        actionLabel: "Claim Now",
        badge: 'No Claim',
      ),
      const RecentStopData(
        title: "Walmart DC Shelbyville",
        subtitle: "Oct 24, 2026 • 08:30 AM",
        amount: "\$75",
        actionLabel: "Rate Shipper",
        badge: 'Denied',
      ),
      const RecentStopData(
        title: "Amazon Distribution DC",
        subtitle: "Oct 23, 2026 • 11:45 AM",
        amount: "\$200",
        actionLabel: "Review Claim",
        badge: 'Submitted',
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GlobalAppBar(
        title: 'All Stops',
        subTitle: 'Track every Log Stops',
        hideBackButton: true,
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              children: [
                16.height,
                _searchInput(),
                SizedBox(height: 15.h),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...List.generate(recentStopData.length, (i) {
                          final item = recentStopData[i];
                          final actionTheme = StatusBadge.resolveColor(
                            item.actionLabel ?? '',
                          );
                          final statusTheme = StatusBadge.resolveColor(
                            item.badge ?? '',
                          );
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: RecentStop(
                              amountColor: statusTheme,
                              iconColor: statusTheme,
                              data: item,
                              badge: item.badge == null
                                  ? null
                                  : StatusBadge.small(status: item.badge!),
                              rightAction: OutlinedButton(
                                onPressed: () {
                                  final label = item.actionLabel
                                      ?.toLowerCase()
                                      .trim();
                                  String? navTo;

                                  switch (label) {
                                    case 'claim now':
                                      navTo = RoutesName.claimDetails;
                                      break;
                                    case 'review claim':
                                      navTo = RoutesName.claimReview;
                                      break;
                                    case 'rate shipper':
                                      navTo = RoutesName.rateShipper;
                                      break;
                                    default:
                                  }

                                  if (navTo != null) {
                                    Navigator.pushNamed(context, navTo);
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: actionTheme.withValues(
                                    alpha: 0.05,
                                  ),
                                  foregroundColor: actionTheme,
                                  side: BorderSide(color: actionTheme),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(item.actionLabel ?? ""),
                              ),
                            ),
                          );
                        }),
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

  Container _searchInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF1D3D36), Color(0XFF18252A)],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_outlined,
            color: Colors.grey.withOpacity(0.7),
            size: 26,
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                hintText: "Search Stops or ID...",
                hintStyle: TextStyle(
                  color: Colors.grey.withValues(alpha: 0.6),
                  fontSize: 18,
                ),

                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

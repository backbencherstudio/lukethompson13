import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';
import 'package:lukethompson/gen/assets.gen.dart';

class SubscriptionInfoCard extends StatelessWidget {
  final Widget? leading;
  final Widget titleWidget;
  final Widget? subtitleWidget;
  final Widget? trailingWidget;
  final VoidCallback? onTap;
  final Color borderColor;

  const SubscriptionInfoCard({
    super.key,
    required this.titleWidget,
    this.leading,
    this.subtitleWidget,
    this.trailingWidget,
    this.onTap,
    this.borderColor = Colors.white10,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        minVerticalPadding: 12,
        tileColor: ColorManager.cardBackground,
        shape: getRoundedCardShape(borderColor),
        onTap: onTap,
        minLeadingWidth: 0,
        titleTextStyle: TextStyle(
          color: ColorManager.whiteColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        subtitleTextStyle: TextStyle(color: ColorManager.subtextColor),
        leading: leading,
        horizontalTitleGap: 12,
        title: titleWidget,
        subtitle: subtitleWidget != null
            ? Padding(
                padding: const EdgeInsets.only(top: 12),
                child: subtitleWidget,
              )
            : null,
        trailing: trailingWidget,
      ),
    );
  }

  factory SubscriptionInfoCard.subscriptionType({
    Key? key,
    required String title,
    required String subtitle,
  }) {
    return SubscriptionInfoCard(
      key: key,
      borderColor: ColorManager.primaryButton,
      titleWidget: Row(
        children: [
          Icon(Icons.access_time, color: ColorManager.primaryButton),
          SizedBox(width: 8),
          Text(title),
        ],
      ),
      subtitleWidget: Text(subtitle),
    );
  }

  factory SubscriptionInfoCard.memberShipType({
    Key? key,
    required String title,
    required String subtitle,
    required int logsRemaining,
  }) {
    return SubscriptionInfoCard(
      key: key,
      titleWidget: Text(title),
      subtitleWidget: Column(
        crossAxisAlignment: .start,
        children: [
          Text(subtitle),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.access_time, color: ColorManager.errorColor),
              SizedBox(width: 8),
              Text(
                "$logsRemaining Logs Remaining",
                style: TextStyle(color: ColorManager.errorColor, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  factory SubscriptionInfoCard.nextBilling({
    Key? key,
    required double amount,
    required String startingDate,
    required String billingDuration,
  }) {
    return SubscriptionInfoCard(
      key: key,
      titleWidget: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text('Next Billing'),
          Text(
            '\$$amount',
            style: TextStyle(color: ColorManager.primaryButton),
          ),
        ],
      ),
      subtitleWidget: Row(
        mainAxisAlignment: .spaceBetween,
        children: [Text(formatStartDate(startingDate)), Text(billingDuration)],
      ),
    );
  }

  factory SubscriptionInfoCard.yourPlanIncludes({
    Key? key,
    required List<String> items,
    required Widget? trailing,
  }) {
    return SubscriptionInfoCard(
      key: key,
      titleWidget: Row(
        children: [
          Icon(Icons.notifications, color: ColorManager.whiteColor, size: 20),
          SizedBox(width: 8),
          Text('Your Plan Includes:'),
        ],
      ),
      subtitleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map(
              (e) => Row(
                children: [
                  SvgPicture.asset(Assets.icons.tickMark),
                  SizedBox(width: 4),
                  Text(e),
                ],
              ),
            )
            .toList(),
      ),
      trailingWidget: trailing,
    );
  }

  static String formatStartDate(String isoString) {
    final date = DateTime.parse(isoString);
    return 'Starting on ${DateFormat('d MMMM yyyy').format(date)}';
  }
}

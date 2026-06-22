import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/presentation/profile/view/widget/recent_activity.dart';
import 'package:lukethompson/presentation/profile/view/widget/subscription_info_card.dart';

class ManageSubscriptionScreen extends StatelessWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(title: 'Manage Subscription'),
      body: AppGradientBackground(
        child: SafeArea(
          child: FullHeightScrollView(
            padding: .symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                24.height,
                SubscriptionInfoCard.subscriptionType(
                  title: 'Free Trial - 5 log',
                  subtitle: 'You will be charged after 5 log used',
                ),
                16.height,
                SubscriptionInfoCard.memberShipType(
                  title: 'Membership Type',
                  subtitle: 'Free trial',
                  logsRemaining: 3,
                ),
                16.height,
                SubscriptionInfoCard.nextBilling(
                  startingDate: '2026-06-22T09:24:03.000Z',
                  billingDuration: 'Per month',
                  amount: 12.99,
                ),
                16.height,
                SubscriptionInfoCard.yourPlanIncludes(
                  items: ['Notify me 2 days before renewal'],
                  trailing: CupertinoSwitch(
                    value: true,
                    onChanged: (value) {
                      // setState(() => isEnabled = value);
                    },
                  ),
                ),
                16.height,
                AppCard(
                  child: Column(
                    children: [
                      AvailableFeatureItem(
                        feature: 'Unlimited stop logging',
                        isAvailable: true,
                      ),
                      4.height,
                      AvailableFeatureItem(
                        feature: 'PDF export',
                        isAvailable: false,
                      ),
                      4.height,
                      AvailableFeatureItem(
                        feature: 'Advanced analytics',
                        isAvailable: true,
                      ),
                      4.height,
                      AvailableFeatureItem(
                        feature: 'Ad-free experience',
                        isAvailable: true,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GlobalButton(label: 'Manage Subscription', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AvailableFeatureItem extends StatelessWidget {
  final String feature;
  final bool isAvailable;
  const AvailableFeatureItem({
    super.key,
    required this.feature,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isAvailable
              ? Icons.check_circle_outline_rounded
              : Icons.cancel_outlined,
          color: isAvailable
              ? ColorManager.primaryButton
              : ColorManager.errorColor,
        ),
        8.width,

        Text(
          feature,
          style: TextStyle(
            color: ColorManager.subtextColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: isAvailable ? null : .lineThrough,
          ),
        ),
      ],
    );
  }
}

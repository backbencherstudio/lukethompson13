import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/svg_circle_icon.dart';
import 'package:lukethompson/presentation/profile/view/widget/shipper_rating_card.dart';

class ShipperRatingsSection extends StatelessWidget {
  final bool isLocked;
  final VoidCallback? onUpgradeTap;

  const ShipperRatingsSection({
    super.key,
    required this.isLocked,
    this.onUpgradeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [_buildRatingsList(), if (isLocked) _buildLockOverlay()],
      ),
    );
  }

  Widget _buildRatingsList() {
    final stats = [
      StatItem(
        value: '127',
        label: 'Claims',
        labelLong: 'Total Claims Submitted',
      ),
      StatItem(
        value: '5 days',
        label: 'Avg Pay',
      ),
      StatItem(
        value: '107',
        label: 'Paid',
        labelLong: 'Total Paid',
      ),
      StatItem(
        value: '107',
        label: 'Denied',
        labelLong: 'Total Denied',
        valueColor: ColorManager.errorColor
      ),
    ];

    return Column(
      children: [
        ShipperRatingCard(
          title: 'Walmart DC - Memphis',
          subtitle: 'Known good payer • Avg. 5 days to pay',
          rating: 80,
          stats: stats,
        ),
        ShipperRatingCard(
          title: 'Target DC - Nashville',
          subtitle: 'Mixed payment history',
          rating: 61,
          stats: stats,
        ),
        ShipperRatingCard(
          title: 'Amazon FC - Dallas TX',
          subtitle: 'Poor payer',
          rating: 32,
          stats: stats,
        ),
        ShipperRatingCard(
          title: 'Amazon FC - Dallas TX',
          subtitle: '12 drivers reported non-payment',
          rating: 28,
          stats: stats,
        ),
      ],
    );
  }

  Widget _buildLockOverlay() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.fromLTRB(
            AppPadding.screenPadding,
            0,
            AppPadding.screenPadding,
            12,
          ),
          child: Column(
            children: [
              140.height,
              SvgCircleIcon(svgPath: Assets.icons.lockIcon),
              12.height,
              Text(
                'Pro plan unlocks the full database of\nShipper Ratings.',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              16.height,
              GlobalButton(
                width: 144,
                height: 40,
                label: 'Upgrade to Pro',
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: onUpgradeTap ?? () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

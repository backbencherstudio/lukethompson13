import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/locked_section.dart';
import 'package:lukethompson/data/sources/remote/shipper/models/shipper.model.dart';
import 'package:lukethompson/data/sources/remote/shipper/shipper_ratings_infinite_scroll.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/svg_circle_icon.dart';
import 'package:lukethompson/presentation/profile/view/widget/shipper_rating_card.dart';

class ShipperRatingsSection extends ConsumerWidget {
  const ShipperRatingsSection({super.key, required this.isLocked});

  final bool isLocked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagination = ref.watch(shipperRatingsPaginationProvider);

    return LockedSection(
      isLocked: isLocked,
      lockedChild: _buildLockedMsg(),
      child: pagination.when(
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        loading: () => const Center(child: ActivityIndicator()),
        error: (e, _) => StatusDisplay.error(e.toString()),
        data: (state) {
          if (state.ratings.isEmpty) {
            return StatusDisplay.muted('No ratings data found');
          }
          return Column(
            children: state.ratings.map((item) {
              return ShipperRatingCard(
                title: item.facilityName,
                subtitle: item.statusSubtext,
                rating: item.rating,
                stats: [
                  StatItem(
                    value: '${item.claimsCount ?? 0}',
                    label: 'Claims',
                    labelLong: 'Total Claims Submitted',
                  ),
                  StatItem(
                    value: '${item.avgPayDays ?? 0} days',
                    label: 'Avg Pay',
                  ),
                  StatItem(
                    value: '${item.paidClaimsCount ?? 0}',
                    label: 'Paid',
                    labelLong: 'Total Paid',
                  ),
                  StatItem(
                    value:
                        '${item.claimsCount ?? 0 - (item.paidClaimsCount ?? 0)}',
                    label: 'Denied',
                    labelLong: 'Total Denied',
                    valueColor: ColorManager.errorColor,
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Column _buildLockedMsg() {
    return Column(
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
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          onPressed: () {},
        ),
      ],
    );
  }

  static const List<ShipperRatingItem> staticShipperRatingItems = [
    ShipperRatingItem(
      id: '1',
      facilityName: 'Walmart DC - Memphis',
      rating: 80,
      statusSubtext: 'Known good payer • Avg. 5 days to pay',
      claimsCount: 127,
      avgPayDays: 5,
      paidClaimsCount: 107,
    ),
    ShipperRatingItem(
      id: '2',
      facilityName: 'Target DC - Nashville',
      rating: 61,
      statusSubtext: 'Mixed payment history',
      claimsCount: 89,
      avgPayDays: 12,
      paidClaimsCount: 45,
    ),
    ShipperRatingItem(
      id: '3',
      facilityName: 'Amazon FC - Dallas TX',
      rating: 32,
      statusSubtext: 'Poor payer',
      claimsCount: 156,
      avgPayDays: 30,
      paidClaimsCount: 32,
    ),
    ShipperRatingItem(
      id: '4',
      facilityName: 'Amazon FC - Houston TX',
      rating: 28,
      statusSubtext: '12 drivers reported non-payment',
      claimsCount: 203,
      avgPayDays: null,
      paidClaimsCount: 18,
    ),
    ShipperRatingItem(
      id: '5',
      facilityName: 'UPS Hub - Louisville',
      rating: 92,
      statusSubtext: 'Fast payer • Avg. 2 days to pay',
      claimsCount: 64,
      avgPayDays: 2,
      paidClaimsCount: 61,
    ),
  ];
}

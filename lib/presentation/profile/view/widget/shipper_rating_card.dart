import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_bottom_sheet.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/spaced_row.dart';
import 'package:lukethompson/presentation/profile/view/widget/shipper_rating_detail_sheet.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class StatItem {
  final String label;
  final String? labelLong;
  final String value;
  final Color? valueColor;
  const StatItem({
    required this.label,
    required this.value,
    this.valueColor = Colors.white,
    this.labelLong,
  });
}

enum PayerCategory {
  good,
  average,
  poor;

  String get label {
    switch (this) {
      case PayerCategory.good:
        return "Good Payers";
      case PayerCategory.average:
        return "Average";
      case PayerCategory.poor:
        return "Poor Payers";
    }
  }

  bool matches(int rating) {
    switch (this) {
      case PayerCategory.good:
        return rating >= 70;
      case PayerCategory.average:
        return rating >= 35 && rating <= 69;
      case PayerCategory.poor:
        return rating <= 34;
    }
  }

  Color get color {
    switch (this) {
      case PayerCategory.good:
        return ColorManager.successColor;
      case PayerCategory.average:
        return ColorManager.warningColor;
      case PayerCategory.poor:
        return ColorManager.errorColor;
    }
  }

  static PayerCategory fromRating(int rating) {
    return PayerCategory.values.firstWhere((c) => c.matches(rating));
  }
}

class ShipperRatingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double rating;
  final List<StatItem> stats;

  const ShipperRatingCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final payer = PayerCategory.fromRating(rating.toInt());

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) {
            return _buildShipperDetailsModalBottomSheet(payer, context);
          },
        );
      },
      child: AppCard(
        borderColor: Colors.transparent,
        // backgroundColor: Colors.transparent,
        margin: EdgeInsets.only(
          left: AppPadding.screenPadding,
          right: AppPadding.screenPadding,
          bottom: 12,
        ),
        child: InkWell(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: getListTitleStyle()),
                      8.height,
                      Text(
                        subtitle,
                        style: getSubtextStyle(
                          color: payer == PayerCategory.poor
                              ? payer.color
                              : null,
                        ),
                      ),
                    ],
                  ),
                  buildCircularProgressBar(payer),
                ],
              ),
              16.height,
              SpacedRow(
                children: stats
                    .take(3)
                    .map(
                      (el) => Expanded(
                        child: AppCard(
                          borderColor: Colors.transparent,
                          borderRadius: 4,
                          backgroundColor: Colors.white.withValues(alpha: 0.04),
                          child: Column(
                            children: [
                              Text(el.value, style: getListTitleStyle()),
                              4.height,
                              Text(el.label, style: getSubtextStyle()),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBottomSheet _buildShipperDetailsModalBottomSheet(
    PayerCategory payer,
    BuildContext context,
  ) {
    return AppBottomSheet(
      title: title,
      subtitle: subtitle,
      child: Column(
        children: [
          buildCircularProgressBar(payer, size: 100, strokeWidth: 10),
          24.height,
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 7 / 3,
            ),
            children: stats
                .map(
                  (el) => AppCard(
                    borderRadius: 4,
                    backgroundColor: Colors.white.withValues(alpha: 0.04),
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          el.value,
                          style: getListTitleStyle(color: el.valueColor),
                        ),
                        4.height,
                        Text(
                          el.labelLong ?? el.label,
                          style: getSubtextStyle(),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),

          // 24.height,
          GlobalButton.primaryOutlined(
            label: 'Close',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  SimpleCircularProgressBar buildCircularProgressBar(
    PayerCategory payer, {
    double size = 80,
    double strokeWidth = 8,
  }) {
    return SimpleCircularProgressBar(
      animationDuration: 0,
      progressColors: [payer.color],
      backStrokeWidth: strokeWidth,
      progressStrokeWidth: strokeWidth,
      backColor: Color(0xff313234),
      size: size,
      valueNotifier: ValueNotifier(rating),
      onGetText: (double value) {
        return Text('${value.toInt()}%', style: TextStyle(fontSize: 16));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_bottom_sheet.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/spaced_row.dart';
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

class ReviewOption {
  const ReviewOption(this.label, this.value);
  final String label;
  final int value;
}

enum PayerCategory {
  good("GOOD_PAYERS", "Good Payers", "Good Payer", 80),
  average('AVERAGE', 'Average', 'Mixed Payer', 50),
  poor('POOR_PAYERS', 'Poor Payers', 'Poor Payer', 0);

  final String value;
  final String label;
  final String reviewLabel;
  final int threshold;

  const PayerCategory(this.value, this.label, this.reviewLabel, this.threshold);

  bool matches(int rating) {
    if (this == good) return rating >= threshold;
    if (this == average) return rating >= threshold && rating < good.threshold;
    return rating < average.threshold;
  }

  Color get color {
    switch (this) {
      case PayerCategory.average:
        return ColorManager.warningColor;
      case PayerCategory.poor:
        return ColorManager.errorColor;
      case PayerCategory.good:
        return ColorManager.successColor;
    }
  }

  static PayerCategory fromRating(int rating) {
    return PayerCategory.values.firstWhere((c) => c.matches(rating));
  }

  static const int _step = 10;
  static final List<ReviewOption> reviewOptions = () {
    final result = <ReviewOption>[];
    for (var value = 100; value >= _step; value -= _step) {
      final cat = fromRating(value);
      result.add(ReviewOption("$value% pay rate - ${cat.reviewLabel}", value));
    }
    return result;
  }();
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
        crossAxisAlignment: .stretch,
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
                    padding: .all(0),
                    backgroundColor: Colors.white.withValues(alpha: 0.04),
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          el.value,
                          style: getListTitleStyle(color: el.valueColor),
                        ),
                        4.height,
                        FittedBox(
                          child: Text(
                            el.labelLong ?? el.label,
                            style: getSubtextStyle(),
                          ),
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

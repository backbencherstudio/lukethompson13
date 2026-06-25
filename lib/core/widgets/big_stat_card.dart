import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';
import 'package:lukethompson/core/widgets/app_card.dart';

class BigStatCard extends StatelessWidget {
  const BigStatCard({
    super.key,
    this.borderColor = Colors.white30,
    this.titleColor,
    this.subtitleColor,
    this.valueColor,
    this.backgroudColor,
    required this.title,
    required this.subtitle,
    required this.value,
  });

  const BigStatCard.success({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
  }) : borderColor = ColorManager.primaryButton,
       valueColor = ColorManager.primaryButton,
       backgroudColor = null,
       titleColor = null,
       subtitleColor = null;

  BigStatCard.destructive({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
  }) : borderColor = ColorManager.errorColor,
       valueColor = ColorManager.errorColor,
       backgroudColor = ColorManager.errorColor.withValues(alpha: 0.12),
       titleColor = null,
       subtitleColor = null;

  final Color? borderColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? valueColor;
  final Color? backgroudColor;

  final String title;
  final String subtitle;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: backgroudColor,
      borderColor: borderColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: getListTitleStyle(color: titleColor)),
          24.height,
          Text(value, style: context.displayLarge.copyWith(color: valueColor)),
          4.height,
          Text(subtitle, style: getSubtextStyle(color: subtitleColor)),
        ],
      ),
    );
  }
}

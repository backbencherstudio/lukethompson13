import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/core/widgets/touchable_opacity.dart';

class BreakdownCard extends StatelessWidget {
  final List<BreakdownItem> items;
  final Color? color;
  final Color? borderColor;

  const BreakdownCard({
    super.key,
    required this.items,
    this.color,
    this.borderColor = Colors.white30,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: color,
      borderColor: borderColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Breakdown', style: getListTitleStyle()),
          ...List.generate(items.length, (index) {
            final item = items[index];
            final isLast = index == items.length - 1;
            return _buildBreakdownItem(
              item.label,
              item.value,
              isLastItem: isLast,
              valueColor: item.valueColor,
              onPressed: item.onPressed,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBreakdownItem(
    String label,
    String value, {
    bool isLastItem = false,
    Color? valueColor,
    void Function()? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: isLastItem
            ? null
            : Border(
                bottom: BorderSide(
                  color: ColorManager.subtextColor,
                  width: 0.2,
                ),
              ),
      ),
      padding: EdgeInsets.only(bottom: isLastItem ? 4 : 12, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: getSubtextStyle()),
          12.width,
          Flexible(
            child: TouchableOpacity(
              onPressed: onPressed,
              child: Text(
                value,
                maxLines: 1,
                overflow: .ellipsis,
                // value,
                style: getListTitleStyle(
                  color: valueColor ?? ColorManager.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BreakdownItem {
  final String label;
  final String value;
  final Color? valueColor;
  final void Function()? onPressed;

  const BreakdownItem({
    required this.label,
    required this.value,
    this.valueColor,
    this.onPressed,
  });
}

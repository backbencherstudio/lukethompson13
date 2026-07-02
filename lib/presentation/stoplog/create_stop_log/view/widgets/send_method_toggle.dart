import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/spaced_row.dart';

class SendMethodToggle extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const SendMethodToggle({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  static const labels = ['Email', 'SMS', 'Share'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.screenPadding),
      child: SpacedRow(
        children: List.generate(labels.length, (index) {
          final isSelected = index == selectedIndex;
          return Expanded(
            child: GlobalButton(
              borderSide: BorderSide(
                color: isSelected
                    ? ColorManager.primaryButton
                    : ColorManager.subtextColor,
              ),
              foregroundColor: isSelected
                  ? ColorManager.primaryButton
                  : ColorManager.subtextColor,
              color: isSelected
                  ? ColorManager.primaryButton.withValues(alpha: 0.12)
                  : ColorManager.subtextColor.withValues(alpha: 0.08),
              label: labels[index],
              onPressed: () => onChanged(index),
            ),
          );
        }),
      ),
    );
  }
}

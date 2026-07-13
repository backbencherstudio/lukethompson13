import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';

class SendMethodToggle extends StatelessWidget {
  final SendMethod selectedMethod;
  final ValueChanged<SendMethod> onChanged;

  const SendMethodToggle({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: List.generate(SendMethod.values.length, (index) {
        final method = SendMethod.values[index];
        final isSelected = method == selectedMethod;
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
            label: method.label,
            onPressed: () => onChanged(method),
          ),
        );
      }),
    );
  }
}

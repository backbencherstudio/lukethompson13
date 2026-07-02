import 'package:flutter/material.dart';
import 'package:lukethompson/core/extensions/text_format_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/dropdown_overlay.dart';
import 'package:lukethompson/core/widgets/section_header.dart';

import 'custom_selection_pop_up.dart';

enum DateRangeType { monthly, yearly }

class TaxPeriodSelector extends StatelessWidget {
  const TaxPeriodSelector({
    super.key,
    this.selectedType,
    this.hintText = 'Select',
    required this.onTypeChanged,
  });

  final DateRangeType? selectedType;
  final String hintText;
  final ValueChanged<DateRangeType?> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    return SectionHeader(
      title: 'Tax Report',
      action: DropdownOverlay(
        triggerBuilder: (context, toggle) => InkWell(
          onTap: toggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Text(
                  selectedType?.name.capitalizeFirst() ?? hintText,
                  style: TextStyle(
                    color: selectedType != null
                        ? ColorManager.primaryButton
                        : ColorManager.subtextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: ColorManager.subtextColor,
                ),
              ],
            ),
          ),
        ),
        popupBuilder: (context, dismiss) => CustomSelectionPopup(
          selectedType: selectedType,
          onSelect: (value) {
            onTypeChanged(value);
            dismiss();
          },
        ),
        targetAnchor: Alignment.bottomCenter,
        followerAnchor: Alignment.topCenter,
      ),
    );
  }
}

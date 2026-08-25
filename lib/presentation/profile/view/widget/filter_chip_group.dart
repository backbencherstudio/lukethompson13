import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/presentation/profile/view/widget/filter_chip.dart';

class FilterChipGroup extends StatelessWidget {
  final List<String> titles;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const FilterChipGroup({
    super.key,
    required this.titles,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: AppPadding.screenPadding),
      child: Row(
        children: List.generate(titles.length, (index) {
          return FilterChipGroupItem(
            title: titles[index],
            isSelected: selectedIndex == index,
            onTap: () => onChanged(index),
          );
        }),
      ),
    );
  }
}

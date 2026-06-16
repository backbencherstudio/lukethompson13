import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:lukethompson/core/widgets/dropdown_overlay.dart';

import 'custom_selection_pop_up.dart';

class CustomDateSelector extends StatefulWidget {
  const CustomDateSelector({super.key});

  @override
  State<CustomDateSelector> createState() => _CustomDateSelectorState();
}

class _CustomDateSelectorState extends State<CustomDateSelector> {
  DateTimeRange? selectedRange;
  String? selectedType;

  Future<void> _openCalendar() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: selectedRange,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(primary: Color(0xFF22C55E)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => selectedRange = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = selectedRange == null
        ? "Select date range"
        : "${DateFormat('MMM dd').format(selectedRange!.start)}-${DateFormat('MMM dd, yyyy').format(selectedRange!.end)}";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2221),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: _openCalendar,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.white54,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              DropdownOverlay(
                triggerBuilder: (context, toggle) => InkWell(
                  onTap: toggle,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          selectedType ?? "Select",
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white54,
                        ),
                      ],
                    ),
                  ),
                ),
                popupBuilder: (context, dismiss) => CustomSelectionPopup(
                  selectedType: selectedType,
                  onSelect: (value) {
                    setState(() => selectedType = value);
                    dismiss();
                  },
                ),
                targetAnchor: Alignment.bottomCenter,
                followerAnchor: Alignment.topCenter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

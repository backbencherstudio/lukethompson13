import 'package:flutter/material.dart';
import 'package:lukethompson/presentation/reports/view/widget/tax_period_selector.dart';

class CustomSelectionPopup extends StatelessWidget {
  final DateRangeType? selectedType;
  final ValueChanged<DateRangeType?> onSelect;

  const CustomSelectionPopup({
    super.key,
    required this.selectedType,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2928),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 10),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(DateRangeType.monthly),
          const SizedBox(height: 4),
          _buildOption(DateRangeType.yearly),
        ],
      ),
    );
  }

  Widget _buildOption(DateRangeType type) {
    final bool isActive = selectedType == type;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => onSelect(type),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF22C55E) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            type.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white60,
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

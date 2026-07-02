import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/app_bottom_sheet.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';

const _allFacilities = [
  'Walmart DC - Memphis, TN',
  'Walmart DC - Dallas, TX',
  'Amazon FC Dallas',
  'Amazon FC Houston',
  'Target RDC - Phoenix, AZ',
  'Costco DC - Atlanta, GA',
  'Home Depot RDC - Charlotte, NC',
  'Lowe\'s DC - Nashville, TN',
  'FedEx Hub - Chicago, IL',
  'UPS Hub - Denver, CO',
  'UPS Hub - Denver, CO',
  'UPS Hub - Denver, CO',
  'UPS Hub - Denver, CO',
  'UPS Hub - Denver, CO',
  'UPS Hub - Denver, CO',
  'UPS Hub - Denver, CO',
  'UPS Hub - Denver, CO',
  'UPS Hub - Denver, CO',
  'UPS Hub - Denver, CO',
  'UPS Hub - Denver, CO',
  'UPS Hub - Denver, CO',
];

Future<String?> showFacilitySearchSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const _FacilitySearchSheetContent(),
  );
}

class _FacilitySearchSheetContent extends StatefulWidget {
  const _FacilitySearchSheetContent();

  @override
  State<_FacilitySearchSheetContent> createState() =>
      _FacilitySearchSheetContentState();
}

class _FacilitySearchSheetContentState
    extends State<_FacilitySearchSheetContent> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  var _filtered = _allFacilities;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = _allFacilities
          .where((f) => f.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: 'Select Facility',
      heightRatio: 0.6,
      fixedHeader: SearchBarWidget(
        hintText: 'Search facilities...',
        controller: _searchController,
        focusNode: _focusNode,
      ),
      child: _filtered.isEmpty
          ? Padding(
              padding: EdgeInsets.only(top: 24, bottom: 48),
              child: Text(
                'No facilities found',
                style: TextStyle(color: ColorManager.subtextColor),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_filtered.length, (index) {
                final facility = _filtered[index];
                final isLast = index == _filtered.length - 1;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        facility,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: ColorManager.subtextColor,
                      ),
                      onTap: () => Navigator.pop(context, facility),
                    ),
                    if (!isLast)
                      Divider(
                        height: 1,
                        thickness: 0.5,
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                  ],
                );
              }),
            ),
    );
  }
}

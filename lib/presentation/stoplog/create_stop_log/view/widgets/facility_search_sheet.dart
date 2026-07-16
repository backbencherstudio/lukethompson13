import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/app_bottom_sheet.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';
import 'package:lukethompson/data/sources/remote/shipper/models/shipper.model.dart';
import 'package:lukethompson/data/sources/remote/shipper/shipper_queries.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/state/facility_search_state.dart';

Future<String?> showFacilitySearchSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const _FacilitySearchSheetContent(),
  );
}

class _FacilitySearchSheetContent extends ConsumerStatefulWidget {
  const _FacilitySearchSheetContent();

  @override
  ConsumerState<_FacilitySearchSheetContent> createState() =>
      _FacilitySearchSheetContentState();
}

class _FacilitySearchSheetContentState
    extends ConsumerState<_FacilitySearchSheetContent> {
  late final TextEditingController _searchController;
  final _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();

    _searchController = TextEditingController(
      text: ref.read(facilitySearchTextProvider),
    );
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final text = _searchController.text;
      ref.read(facilitySearchTextProvider.notifier).setText(text);
      if (text.isNotEmpty) {
        ref
            .read(getSearchAllShipperFacilitiesProvider.notifier)
            .search(ShipperSearchParams(search: text));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchText = ref.watch(facilitySearchTextProvider);
    final facilities = ref.watch(getSearchAllShipperFacilitiesProvider);

    return AppBottomSheet(
      title: 'Select Facility',
      heightRatio: 0.9,
      fixedHeader: Column(
        children: [
          SearchBarWidget(
            hintText: 'Search facilities...',
            controller: _searchController,
            focusNode: _focusNode,
          ),
          6.height,
        ],
      ),
      child: facilities.when(
        loading: () => null,
        error: (_, _) {
          if (searchText.isNotEmpty) {
            return buildAddButton(searchText, context);
          }
          return null;
        },
        data: (items) {
          if (searchText.isEmpty) {
            return null;
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (searchText.isNotEmpty) buildAddButton(searchText, context),

              if (items != null)
                for (final (index, item) in items.indexed) ...[
                  buildSearchItem(item, context, index == items.length - 1),
                ],
            ],
          );
        },
      ),
    );
  }

  ListTile buildAddButton(String searchText, BuildContext context) {
    return ListTile(
      title: Text(
        'Add "$searchText"',
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.pop(context, searchText);
      },
    );
  }

  Column buildSearchItem(
    ShipperSearchFacilityItem item,
    BuildContext context,
    bool isLast,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(item.name, style: const TextStyle(color: Colors.white)),
          subtitle: item.address != null
              ? Text(
                  item.address!,
                  style: const TextStyle(
                    color: ColorManager.subtextColor,
                    fontSize: 12,
                  ),
                )
              : null,
          trailing: const Icon(
            Icons.chevron_right,
            color: ColorManager.subtextColor,
          ),
          onTap: () => Navigator.pop(context, item.name),
        ),
        if (!isLast)
          Divider(
            height: 1,
            thickness: 0.5,
            color: Colors.white.withValues(alpha: 0.08),
          ),
      ],
    );
  }
}

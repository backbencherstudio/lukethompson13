import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_bottom_sheet.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';
import 'package:lukethompson/data/sources/remote/shipper/models/shipper.model.dart';
import 'package:lukethompson/data/sources/remote/shipper/shipper_queries.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/state/facility_search_state.dart';

Future<ShipperSearchFacilityItem?> showFacilitySearchSheet(
  BuildContext context, {
  FacilityType facilityType = FacilityType.shipper,
}) {
  return showModalBottomSheet<ShipperSearchFacilityItem>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _FacilitySearchSheetContent(facilityType: facilityType),
  );
}

class _FacilitySearchSheetContent extends ConsumerStatefulWidget {
  const _FacilitySearchSheetContent({required this.facilityType});

  final FacilityType facilityType;

  @override
  ConsumerState<_FacilitySearchSheetContent> createState() =>
      _FacilitySearchSheetContentState();
}

class _FacilitySearchSheetContentState
    extends ConsumerState<_FacilitySearchSheetContent> {
  late final TextEditingController _searchController;
  final _focusNode = FocusNode();
  Timer? _debounce;

  bool get isBrokerSearch => widget.facilityType == .broker;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();

    _searchController = TextEditingController(
      text: widget.facilityType == .shipper
          ? ref.read(selectedFacilityProvider)?.name ?? ''
          : '',
    );
    _searchController.addListener(_onSearchChanged);

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      ref
          .read(getSearchAllShipperFacilitiesProvider.notifier)
          .searchInitialData(widget.facilityType);
    });
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
      if (text.isNotEmpty) {
        ref
            .read(getSearchAllShipperFacilitiesProvider.notifier)
            .search(
              ShipperSearchParams(search: text, type: widget.facilityType),
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final facilitiesState = ref.watch(getSearchAllShipperFacilitiesProvider);

    return AppBottomSheet(
      title: isBrokerSearch ? 'Select Broker' : 'Select Facility',
      heightRatio: 0.9,
      fixedHeader: Column(
        children: [
          SearchBarWidget(
            hintText: isBrokerSearch
                ? 'Search broker...'
                : 'Search facilities...',
            controller: _searchController,
            focusNode: _focusNode,
            suffixIcon: IconButton(
              onPressed: () {
                _searchController.clear();
                ref
                    .read(getSearchAllShipperFacilitiesProvider.notifier)
                    .searchInitialData(widget.facilityType);
              },
              icon: Icon(
                Icons.close,
                color: ColorManager.subtextColorGrey,
                size: 20,
              ),
            ),
          ),
          6.height,
        ],
      ),
      child: facilitiesState.when(
        loading: () => Padding(
          padding: const EdgeInsets.only(top: 32),
          child: ActivityIndicator(),
        ),
        error: (err, st) {
          return StatusDisplay.error("something went wrong");
        },
        data: (items) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (items != null && items.isEmpty)
                StatusDisplay.error("No Item found"),

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

  Widget buildAddButton(String searchText, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Text(
          'Add "$searchText"',
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {
          Navigator.pop(
            context,
            ShipperSearchFacilityItem(id: '', name: searchText, rating: 0),
          );
        },
      ),
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
        Material(
          color: Colors.transparent,
          child: ListTile(
            title: Text(item.name, style: const TextStyle(color: Colors.white)),
            subtitle: item.address != null
                ? Text(
                    isBrokerSearch ? item.email ?? '' : item.address ?? '',
                    style: const TextStyle(
                      color: ColorManager.subtextColor,
                      fontSize: 12,
                    ),
                    overflow: .ellipsis,
                  )
                : null,
            trailing: const Icon(
              Icons.chevron_right,
              color: ColorManager.subtextColor,
            ),
            onTap: () => Navigator.pop(context, item),
          ),
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

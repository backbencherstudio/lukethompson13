import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/platform/gps_service.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/app_bottom_sheet.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/state/location_search_state.dart';

Future<LocationDataModel?> showLocationSearchSheet(BuildContext context) {
  return showModalBottomSheet<LocationDataModel>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const _LocationSearchSheetContent(),
  );
}

class _LocationSearchSheetContent extends ConsumerStatefulWidget {
  const _LocationSearchSheetContent();

  @override
  ConsumerState<_LocationSearchSheetContent> createState() =>
      _LocationSearchSheetContentState();
}

class _LocationSearchSheetContentState
    extends ConsumerState<_LocationSearchSheetContent> {
  late final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _debounce;

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
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(locationSearchProvider.notifier).search(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(locationSearchProvider);

    return AppBottomSheet(
      title: 'Search Address',
      heightRatio: 0.8,
      fixedHeader: Column(
        children: [
          SearchBarWidget(
            hintText: 'e.g. 277 Bedford Ave, Brooklyn, NY',
            controller: _searchController,
            focusNode: _focusNode,
            suffixIcon: IconButton(
              onPressed: () {
                _searchController.clear();
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
      child: searchResults.when(
        loading: () => null,
        error: (_, _) {
          return StatusDisplay.muted("No result found");
          // if (searchText.isNotEmpty) {
          //   return buildAddButton(searchText, context);
          // }
          // return null;
        },
        data: (items) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final (index, item) in items.indexed)
                buildSearchItem(item, context, index == items.length - 1),
            ],
          );
        },
      ),
    );
  }

  // Widget buildAddButton(String searchText, BuildContext context) {
  //   return Material(
  //     color: Colors.transparent,
  //     child: ListTile(
  //       title: Text(
  //         'Use "$searchText"',
  //         style: const TextStyle(color: Colors.white),
  //       ),
  //       onTap: () {
  //         Navigator.pop(
  //           context,
  //           ShipperSearchFacilityItem(id: '', name: searchText, rating: 0),
  //         );
  //       },
  //     ),
  //   );
  // }

  Column buildSearchItem(
    LocationDataModel item,
    BuildContext context,
    bool isLast,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: ListTile(
            title: Text(
              item.address,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              '${item.latitude.toStringAsFixed(4)}, '
              '${item.longitude.toStringAsFixed(4)}',
              style: const TextStyle(
                color: ColorManager.subtextColor,
                fontSize: 12,
              ),
            ),
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

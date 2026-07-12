import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';
import 'package:lukethompson/data/providers/shipper_ratings_infinite_scroll.dart';
import 'package:lukethompson/presentation/profile/view/widget/filter_chip_group.dart';
import 'package:lukethompson/presentation/profile/view/widget/shipper_rating_card.dart';
import 'package:lukethompson/presentation/profile/view/widget/shipper_ratings_section.dart';

class ShipperRatingsScreen extends ConsumerStatefulWidget {
  const ShipperRatingsScreen({super.key});

  @override
  ConsumerState<ShipperRatingsScreen> createState() =>
      _ShipperRatingsScreenState();
}

class _ShipperRatingsScreenState extends ConsumerState<ShipperRatingsScreen> {
  late final TextEditingController _searchController;
  int _selectedTabFilterIndex = 0;
  bool _pageLocked = false;

  final List<String> categories = PayerCategory.values
      .map((e) => e.label)
      .toList();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pagination = ref.watch(shipperRatingsPaginationProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(title: 'Shipper Ratings'),
      body: AppGradientBackground(
        child: SafeArea(
          bottom: false,
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
                ref
                    .read(shipperRatingsPaginationProvider.notifier)
                    .loadNextPage();
              }
              return false;
            },
            child: FullHeightScrollView(
              physics: _pageLocked
                  ? const NeverScrollableScrollPhysics()
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  SearchBarWidget(
                    controller: _searchController,
                    hintText: 'Search facilities...',
                    margin: .symmetric(horizontal: AppPadding.screenPadding),
                    onChanged: (value) {
                      ref
                          .read(shipperRatingsPaginationProvider.notifier)
                          .updateSearch(value);
                    },
                  ),
                  FilterChipGroup(
                    titles: categories,
                    selectedIndex: _selectedTabFilterIndex,
                    onChanged: (index) {
                      setState(() {
                        _selectedTabFilterIndex = index;
                      });
                      final status = index == 0
                          ? null
                          : PayerCategory.values[index - 1];
                      ref
                          .read(shipperRatingsPaginationProvider.notifier)
                          .updateStatus(status);
                    },
                  ),
                  ShipperRatingsSection(isLocked: _pageLocked),
                  pagination.when(
                    data: (state) {
                      if (state.isLoadingMore) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: ActivityIndicator()),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    error: (_, _) => const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

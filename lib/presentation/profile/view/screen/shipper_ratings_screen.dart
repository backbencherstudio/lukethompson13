import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/services/revenuecat_providers.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';
import 'package:lukethompson/data/sources/remote/shipper/shipper_ratings_infinite_scroll.dart';
import 'package:lukethompson/gen/assets.gen.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/svg_circle_icon.dart';
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
    final isProSubscription = ref.watch(isProSubscriptionProvider);
    final isPageLocked = !isProSubscription;
    final pagination = isPageLocked
        ? AsyncData(ShipperRatingsPaginationState.empty())
        : ref.watch(shipperRatingsPaginationProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(title: 'Broker & Doc Scores'),
      body: AppGradientBackground(
        child: SafeArea(
          bottom: false,
          child: NestedScrollView(
            physics: isPageLocked ? const NeverScrollableScrollPhysics() : null,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(child: SizedBox(height: 6.h)),
              SliverToBoxAdapter(
                child: SearchBarWidget(
                  controller: _searchController,
                  hintText: 'Search facilities...',
                  margin: .symmetric(horizontal: AppPadding.screenPadding),
                  onChanged: (value) {
                    ref
                        .read(shipperRatingsPaginationProvider.notifier)
                        .updateSearch(value);
                  },
                ),
              ),
            ],
            body: NotificationListener<ScrollNotification>(
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
                physics: isPageLocked
                    ? const NeverScrollableScrollPhysics()
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16,
                  children: [
                    0.height,
                    FilterChipGroup(
                      titles: PayerCategory.categories,
                      selectedIndex: _selectedTabFilterIndex,
                      onChanged: (index) {
                        if (isPageLocked) return;

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
                    ShipperRatingsSection(
                      isLocked: isPageLocked,
                      lockedPrompt: Column(
                        children: [
                          140.height,
                          SvgCircleIcon(svgPath: Assets.icons.lockIcon),
                          12.height,
                          Text(
                            'Pro plan unlocks the full database of\nShipper Ratings.',
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          16.height,
                          GlobalButton(
                            width: 144,
                            height: 40,
                            label: 'Upgrade to Pro',
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            onPressed: () {
                              context.push(Routes.chooseSubscriptionPlan);
                            },
                          ),
                        ],
                      ),
                    ),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/status_display.dart';
import 'package:lukethompson/presentation/profile/view/widget/claim_list_section.dart';
import 'package:lukethompson/presentation/profile/view/widget/claim_stats_section.dart';
import 'package:lukethompson/presentation/profile/view/widget/filter_chip_group.dart';

class MyClaimScreen extends ConsumerStatefulWidget {
  const MyClaimScreen({super.key});

  @override
  ConsumerState<MyClaimScreen> createState() => _MyClaimScreenState();
}

class _MyClaimScreenState extends ConsumerState<MyClaimScreen> {
  late final TextEditingController _searchController;
  int selectedIndex = 0;

  List<String> _buildCategories(ClaimCounts? counts) {
    return [
      "All${counts != null ? ' (${counts.all})' : ''}",
      "Submitted${counts != null ? ' (${counts.submitted})' : ''}",
      "Draft${counts != null ? ' (${counts.draft})' : ''}",
      "Paid${counts != null ? ' (${counts.paid})' : ''}",
      "Denied${counts != null ? ' (${counts.denied})' : ''}",
    ];
  }

  final List<ClaimStatus?> _statusFilters = [
    null,
    ClaimStatus.submitted,
    ClaimStatus.draft,
    ClaimStatus.paid,
    ClaimStatus.denied,
  ];

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
    final pagination = ref.watch(claimPaginationProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(
        title: 'My Claim',
        subTitle: "Track every detention claim you've filed",
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              16.height,
              SearchBarWidget(
                margin: EdgeInsets.symmetric(
                  horizontal: AppPadding.screenPadding,
                ),
                controller: _searchController,
                onChanged: (value) {
                  ref
                      .read(claimPaginationProvider.notifier)
                      .updateSearch(value);
                },
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels >=
                        scrollInfo.metrics.maxScrollExtent - 200) {
                      ref.read(claimPaginationProvider.notifier).loadNextPage();
                    }
                    return false;
                  },
                  child: pagination.when(
                    skipLoadingOnRefresh: true,
                    skipLoadingOnReload: true,
                    loading: () => const Center(child: ActivityIndicator()),
                    error: (e, _) => StatusDisplay.error(e.toString()),
                    data: (state) {
                      return FullHeightScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FilterChipGroup(
                              titles: _buildCategories(state.metaData?.counts),
                              selectedIndex: selectedIndex,
                              onChanged: (index) {
                                setState(() {
                                  selectedIndex = index;
                                });
                                final status = _statusFilters[index];
                                ref
                                    .read(claimPaginationProvider.notifier)
                                    .updateStatus(status);
                              },
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.screenPadding,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClaimStatsSection(
                                    metaData: state.metaData,
                                  ),
                                  SizedBox(height: 16.h),
                                  ClaimListSection(
                                    claims: state.claims,
                                    isLoadingMore: state.isLoadingMore,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

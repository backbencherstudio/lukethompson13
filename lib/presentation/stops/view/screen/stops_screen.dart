import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/data/providers/stoplog_list_infinite_scroll.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/recent_stop.dart';

class StopsScreen extends ConsumerStatefulWidget {
  const StopsScreen({super.key});

  @override
  ConsumerState<StopsScreen> createState() => _StopsScreenState();
}

class _StopsScreenState extends ConsumerState<StopsScreen> {
  late final TextEditingController _searchController;

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
    final paginationState = ref.watch(stopLogPaginationProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: const GlobalAppBar(
        title: 'All Stops',
        subTitle: 'Track every Log Stops',
        hideBackButton: true,
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              children: [
                16.height,
                _searchInput(),
                SizedBox(height: 15.h),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 200) {
                        ref
                            .read(stopLogPaginationProvider.notifier)
                            .loadNextPage();
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          RecentStopList(
                            value: paginationState.whenData(
                              (state) => state.stops,
                            ),
                          ),
                          paginationState.when(
                            data: (state) {
                              if (state.isLoadingMore) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: const Center(
                                    child: ActivityIndicator(),
                                  ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _searchInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF1D3D36), Color(0XFF18252A)],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_outlined,
            color: Colors.grey.withValues(alpha: 0.7),
            size: 26,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                ref
                    .read(stopLogPaginationProvider.notifier)
                    .updateSearch(value);
              },
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                hintText: "Search Stops or ID...",
                hintStyle: TextStyle(
                  color: Colors.grey.withValues(alpha: 0.6),
                  fontSize: 18,
                ),
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

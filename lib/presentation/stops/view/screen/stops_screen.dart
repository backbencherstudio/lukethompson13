import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/data/models/stops/stop_log_list_response.model.dart';
import 'package:lukethompson/data/providers/stoplog_queries.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/recent_stop.dart';

// TODO: use infinity scroll and search
class StopsScreen extends ConsumerWidget {
  const StopsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentStops = ref.watch(getStoplogListQuery(StopLogListParams()));


    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GlobalAppBar(
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
                  child: SingleChildScrollView(
                    child: RecentStopList(value: recentStops),
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF1D3D36), Color(0XFF18252A)],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_outlined,
            color: Colors.grey.withOpacity(0.7),
            size: 26,
          ),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white, fontSize: 18),
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

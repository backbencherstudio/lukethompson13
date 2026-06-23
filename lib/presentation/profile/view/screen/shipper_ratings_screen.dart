import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';
import 'package:lukethompson/presentation/profile/view/widget/row_container.dart';
import 'package:lukethompson/presentation/profile/view/widget/shipper_rating_card.dart';
import 'package:lukethompson/presentation/profile/view/widget/shipper_ratings_section.dart';

class ShipperRatingsScreen extends StatefulWidget {
  const ShipperRatingsScreen({super.key});

  @override
  State<ShipperRatingsScreen> createState() => _ShipperRatingsScreenState();
}

class _ShipperRatingsScreenState extends State<ShipperRatingsScreen> {
  int _selectedTabFilterIndex = 0;
  bool _pageLocked = true;

  final List<String> categories = [
    "All",
    ...PayerCategory.values.map((e) => e.label),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(title: 'Shipper Ratings'),
      body: AppGradientBackground(
        child: SafeArea(
          bottom: false,
          child: FullHeightScrollView(
            physics: _pageLocked ? const NeverScrollableScrollPhysics() : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.h),
                Padding(
                  padding: .symmetric(horizontal: AppPadding.screenPadding),
                  child: const SearchBarWidget(
                    hintText: 'Search facilities...',
                  ),
                ),
                SizedBox(height: 16.h),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: .only(left: AppPadding.screenPadding),
                  child: Row(
                    children: List.generate(categories.length, (index) {
                      return RowContainer(
                        title: categories[index],
                        isSelected: _selectedTabFilterIndex == index,
                        onTap: () {
                          setState(() {
                            _selectedTabFilterIndex = index;
                          });
                        },
                      );
                    }),
                  ),
                ),
                SizedBox(height: 16.h),
                ShipperRatingsSection(
                  isLocked: _pageLocked,
                  onUpgradeTap: () {
                    setState(() {
                      _pageLocked = false;
                    });
                  },
                ),
                16.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

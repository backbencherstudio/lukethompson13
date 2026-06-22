import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/style_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';
import 'package:lukethompson/core/widgets/spaced_row.dart';
import 'package:lukethompson/presentation/profile/view/widget/row_container.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class ShipperRatingsScreen extends StatefulWidget {
  const ShipperRatingsScreen({super.key});

  @override
  State<ShipperRatingsScreen> createState() => _ShipperRatingsScreenState();
}

class _ShipperRatingsScreenState extends State<ShipperRatingsScreen> {
  int selectedIndex = 0;

  final List<String> categories = [
    "All",
    "Good Payers",
    "Average",
    "Poor Payers",
  ];

  final List<List<String>> stats = [
    ['Claims', '127'],
    ['Avg Pay', '5 days'],
    ['Paid', '107'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(title: 'Shipper Ratings'),
      body: AppGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
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
                        isSelected: selectedIndex == index,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      );
                    }),
                  ),
                ),
                SizedBox(height: 16.h),
                AppCard(
                  borderColor: Colors.transparent,
                  margin: .symmetric(horizontal: AppPadding.screenPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                'Walmart DC - Memphis',
                                style: getListTitleStyle(),
                              ),
                              8.height,
                              Text(
                                'Walmart DC - Memphis',
                                style: getSubtextStyle(),
                              ),
                            ],
                          ),

                          SimpleCircularProgressBar(
                            backStrokeWidth: 8,
                            progressStrokeWidth: 8,
                            size: 80,
                            valueNotifier: ValueNotifier(100),
                            mergeMode: true,
                            onGetText: (double value) {
                              return Text(
                                '${value.toInt()}%',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      16.height,
                      SpacedRow(
                        children: stats
                            .map(
                              (el) => Expanded(
                                child: AppCard(
                                  borderColor: Colors.transparent,
                                  borderRadius: 4,
                                  backgroundColor: Colors.white.withValues(
                                    alpha: 0.04,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(el[1], style: getListTitleStyle()),
                                      4.height,
                                      Text(el[0], style: getSubtextStyle()),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),

                // --- Stats Widgets ---
              ],
            ),
          ),
        ),
      ),
    );
  }
}

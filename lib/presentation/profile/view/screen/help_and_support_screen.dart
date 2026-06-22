import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/expansion_tile_radio_list_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/section_header.dart';

class FAQItem {
  final int id;
  final String title;
  final String content;

  FAQItem({required this.id, required this.title, required this.content});
}

final _instructions = [
  FAQItem(
    id: 1,
    title: 'Filing a Claim',
    content:
        'Learn how to easily file a claim using our app. We provide step-by-step guidance to ensure you have everything you need for a successful submission.',
  ),
  FAQItem(
    id: 2,
    title: 'Document Requirements',
    content:
        'Learn how to easily file a claim using our app. We provide step-by-step guidance to ensure you have everything you need for a successful submission.',
  ),
  FAQItem(
    id: 3,
    title: 'Claim Processing Time',
    content:
        'Learn how to easily file a claim using our app. We provide step-by-step guidance to ensure you have everything you need for a successful submission.',
  ),
  FAQItem(
    id: 4,
    title: 'Denied Claims',
    content:
        'Learn how to easily file a claim using our app. We provide step-by-step guidance to ensure you have everything you need for a successful submission.',
  ),
  FAQItem(
    id: 5,
    title: 'Tracking Your Claim',
    content:
        'Learn how to easily file a claim using our app. We provide step-by-step guidance to ensure you have everything you need for a successful submission.',
  ),
  FAQItem(
    id: 6,
    title: 'Escalation Process',
    content:
        'Learn how to easily file a claim using our app. We provide step-by-step guidance to ensure you have everything you need for a successful submission.',
  ),
];

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(title: 'Help & Support'),
      body: AppGradientBackground(
        child: SafeArea(
          child: Padding(
            padding: .symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              children: [
                24.height,
                SectionHeader(title: 'How Can We Help You?'),
                16.height,
                Expanded(
                  child: ExpansionTileRadioListView(
                    items: _instructions,
                    titleBuilder: (context, item, index) {
                      return Text(
                        "${index + 1}. ${item.title}",
                        style: TextStyle(fontSize: 16.sp),
                      );
                    },
                    childrenBuilder: (context, item, index) {
                      return Text(
                        item.content,
                        style: TextStyle(
                          fontSize: 14.sp,
                          height: 1.3,
                          color: ColorManager.subtextColor,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

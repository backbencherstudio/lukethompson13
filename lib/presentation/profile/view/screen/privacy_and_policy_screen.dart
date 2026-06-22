import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';

class FAQItem {
  final int id;
  final String title;
  final String content;

  FAQItem({required this.id, required this.title, required this.content});
}

final _policyContents = [
  'Donec vitae mi vulputate, suscipit urna in, malesuada nisl. Pellentesque laoreet pretium nisl, et pulvinar massa eleifend sed. Curabitur maximus mollis diam, vel varius sapien suscipit eget. Cras sollicitudin ligula at volutpat ultrices. Nunc arcu enim, rhoncus eu maximus id, malesuada eu neque.',
  'Vestibulum tempus imperdiet sem ac porttitor. Vivamus pulvinar commodo orci, suscipit porttitor velit elementum non. Fusce nec pellentesque erat, id lobortis nunc. Donec dui leo, ultrices quis turpis nec, sollicitudin sodales tortor. Aenean dapibus magna quam, id tincidunt quam placerat consequat. Nulla eu laoreet ex.',
  'Vestibulum nec vulputate turpis, id euismod orci. Phasellus consectetur tortor est. Donec lectus ex, rhoncus ac consequat at, viverra sit amet sem. Aliquam sed vestibulum nibh. Phasellus ut lorem pharetra, placerat urna id, tincidunt quam. Praesent non ex congue, tristique risus quis, blandit purus. Sed tristique sapien ut vehicula pretium. Donec purus metus, vulputate sit amet ullamcorper vel, aliquet ac lectus.',
];

class PrivacyAndPolicyScreen extends StatelessWidget {
  const PrivacyAndPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(title: 'Privacy & Policy'),
      body: AppGradientBackground(
        child: SafeArea(
          child: ListView.separated(
            padding: .only(
              left: AppPadding.screenPadding,
              right: AppPadding.screenPadding,
              top: 24,
            ),
            itemBuilder: ((context, index) => Text(
              _policyContents[index],
              style: TextStyle(fontSize: 16.sp, height: 1.5),
            )),
            separatorBuilder: (_, _) => const SizedBox(height: 24),
            itemCount: _policyContents.length,
          ),
        ),
      ),
    );
  }
}

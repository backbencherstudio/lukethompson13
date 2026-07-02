import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/facility_search_sheet.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/info_banner.dart';

class FacilitySection extends StatefulWidget {
  const FacilitySection({super.key});

  @override
  State<FacilitySection> createState() => _FacilitySectionState();
}

class _FacilitySectionState extends State<FacilitySection> {
  final _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController(
    text: 'Walmart DC - Memphis, TN',
  );

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("FACILITY NAME", style: context.labelLarge),
        SizedBox(height: 8.h),
        SearchBarWidget(
          hintText: "Search facilities...",
          controller: _controller,
          focusNode: _focusNode,
          onTap: () async {
            final result = await showFacilitySearchSheet(context);
            _focusNode.unfocus();
            if (result != null) {
              _controller.text = result;
            }
          },
        ),
        SizedBox(height: 15.h),
        InfoBanner(
          icon: Icons.warning_amber_rounded,
          title: "Heads up - Amazon FC Dallas",
          content:
              "8 GetDockPay drivers reported slow or no payment here. Attach your BOL and document everything.",
          titleColor: ColorManager.errorColor,
        ),
      ],
    );
  }
}

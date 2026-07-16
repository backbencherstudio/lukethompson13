import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/state/facility_search_state.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/facility_search_sheet.dart';

class FacilitySection extends ConsumerStatefulWidget {
  const FacilitySection({super.key});

  @override
  ConsumerState<FacilitySection> createState() => _FacilitySectionState();
}

class _FacilitySectionState extends ConsumerState<FacilitySection> {
  final _focusNode = FocusNode();
  late final TextEditingController _controller;

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: ref.read(facilitySearchTextProvider),
    );
    _controller.addListener(() {
      ref.read(facilitySearchTextProvider.notifier).setText(_controller.text);
    });

    ref.listenManual<String>(facilitySearchTextProvider, (previous, next) {
      if (_controller.text != next) {
        _controller.value = TextEditingValue(
          text: next,
          selection: TextSelection.collapsed(offset: next.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("FACILITY NAME", style: context.labelLarge),
        SizedBox(height: 8.h),
        SearchBarWidget(
          hintText: "Search or enter a facility name...",
          controller: _controller,
          focusNode: _focusNode,
          onTap: () async {
            final result = await showFacilitySearchSheet(context);
            _focusNode.unfocus();
            if (result != null) {
              ref
                  .read(facilitySearchTextProvider.notifier)
                  .setText(result);
            }
          },
        ),
      ],
    );
  }
}

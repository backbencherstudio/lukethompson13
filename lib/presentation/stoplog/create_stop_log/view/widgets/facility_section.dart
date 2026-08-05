import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/widgets/search_bar_widget.dart';
import 'package:lukethompson/data/sources/remote/shipper/models/shipper.model.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/state/facility_search_state.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/facility_search_sheet.dart';

class FacilitySection extends ConsumerStatefulWidget {
  const FacilitySection({
    super.key,
    required this.onFacilitySelect,
    required this.disableSearchField,
  });

  final bool disableSearchField;
  final void Function(ShipperSearchFacilityItem? facility) onFacilitySelect;

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
      text: ref.read(selectedFacilityProvider)?.name ?? '',
    );

    ref.listenManual<ShipperSearchFacilityItem?>(selectedFacilityProvider, (
      previous,
      next,
    ) {
      final text = next?.name ?? '';
      if (_controller.text != text) {
        _controller.value = TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
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
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: SearchBarWidget(
                enabled: !widget.disableSearchField,
                hintText: "Search or enter a facility name...",
                controller: _controller,
                focusNode: _focusNode,
                onTap: () async {
                  final result = await showFacilitySearchSheet(context);
                  _focusNode.unfocus();
                  if (result != null) {
                    widget.onFacilitySelect(result);
                    ref.read(selectedFacilityProvider.notifier).select(result);
                  }
                },
              ),
            ),

            IconButton.filled(
              onPressed: () => context.push(Routes.createFacility),
              icon: const Icon(Icons.add_rounded, size: 26),
              style: IconButton.styleFrom(
                fixedSize: Size.square(54),
                backgroundColor: ColorManager.primaryButton,
                foregroundColor: Colors.white, // Icon color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

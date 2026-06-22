import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class ExpansionTileRadioListView<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) titleBuilder;
  final Widget Function(BuildContext context, T item, int index)
  childrenBuilder;

  final EdgeInsetsGeometry? padding;
  final double separatorHeight;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const ExpansionTileRadioListView({
    super.key,
    required this.items,
    required this.titleBuilder,
    required this.childrenBuilder,
    this.padding,
    this.separatorHeight = 12,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  State<ExpansionTileRadioListView<T>> createState() =>
      _ExpansionTileRadioListViewState<T>();
}

class _ExpansionTileRadioListViewState<T>
    extends State<ExpansionTileRadioListView<T>> {
  late final List<ExpansibleController> _controllers;
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      widget.items.length,
      (_) => ExpansibleController(),
    );
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _handleExpand(int index, bool expanded) {
    if (expanded) {
      if (_expandedIndex != null && _expandedIndex != index) {
        _controllers[_expandedIndex!].collapse();
      }
      _expandedIndex = index;
    } else {
      if (_expandedIndex == index) {
        _expandedIndex = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      itemCount: widget.items.length,
      separatorBuilder: (_, _) => SizedBox(height: widget.separatorHeight),
      itemBuilder: (context, index) {
        final item = widget.items[index];

        return ExpansionTile(
          controller: _controllers[index],
          onExpansionChanged: (expanded) => _handleExpand(index, expanded),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          backgroundColor: ColorManager.cardBackground,
          collapsedBackgroundColor: ColorManager.cardBackground,

          textColor: ColorManager.whiteColor,
          iconColor: ColorManager.whiteColor,
          collapsedIconColor: ColorManager.subtextColor,
          collapsedTextColor: ColorManager.whiteColor,

          tilePadding: const EdgeInsets.symmetric(horizontal: 20),
          childrenPadding: const EdgeInsets.all(16),

          title: widget.titleBuilder(context, item, index),
          children: [widget.childrenBuilder(context, item, index)],
        );
      },
    );
  }
}

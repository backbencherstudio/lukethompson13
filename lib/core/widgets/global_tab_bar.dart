import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class GlobalTabBar extends StatelessWidget {
  final TabController controller;
  final List<Tab> tabs;
  final ValueChanged<int>? onTap;
  final bool isEnabled;
  final double height;
  final double borderRadius;
  final double tabBarPadding;
  final double indicatorHorizontalPadding;
  final double indicatorVerticalPadding;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final TextStyle? labelStyle;

  const GlobalTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    this.onTap,
    this.isEnabled = true,
    this.height = 64,
    this.borderRadius = 34,
    this.tabBarPadding = 6,
    this.indicatorHorizontalPadding = 4,
    this.indicatorVerticalPadding = 2,
    this.backgroundColor = const Color(0xFF26323D),
    this.indicatorColor,
    this.labelColor = Colors.white,
    this.unselectedLabelColor = const Color(0xFF9CA8B3),
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: TabBar(
          labelStyle:
              labelStyle ??
              TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          padding: EdgeInsets.all(tabBarPadding),
          indicatorPadding: EdgeInsets.symmetric(
            horizontal: indicatorHorizontalPadding,
            vertical: indicatorVerticalPadding,
          ),
          splashBorderRadius: BorderRadius.circular(borderRadius - 6),
          controller: controller,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: indicatorColor ?? ColorManager.primaryButton,
            borderRadius: BorderRadius.circular(borderRadius - 6),
          ),
          labelColor: labelColor,
          unselectedLabelColor: unselectedLabelColor,
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: isEnabled ? onTap : null,
          tabs: tabs,
        ),
      ),
    );
  }
}

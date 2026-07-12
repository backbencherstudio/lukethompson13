import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';

class LockedOverlay extends StatelessWidget {
  const LockedOverlay({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.fromLTRB(
            AppPadding.screenPadding,
            0,
            AppPadding.screenPadding,
            12,
          ),
          child: child,
        ),
      ),
    );
  }
}

class LockedSection extends StatelessWidget {
  final bool isLocked;
  final Widget lockedChild;
  final Widget child;

  const LockedSection({
    super.key,
    required this.isLocked,
    required this.child,
    required this.lockedChild,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          if (isLocked) LockedOverlay(child: lockedChild),
        ],
      ),
    );
  }
}

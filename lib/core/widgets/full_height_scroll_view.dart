import 'package:flutter/material.dart';

class FullHeightScrollView extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const FullHeightScrollView({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: padding ?? EdgeInsets.zero,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(child: child),
          ),
        );
      },
    );
  }
}

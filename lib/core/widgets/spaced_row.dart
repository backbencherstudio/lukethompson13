import 'package:flutter/material.dart';

class SpacedRow extends Row {
  SpacedRow({
    super.key,
    double gap = 12,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.mainAxisSize,
    required List<Widget> children,
  }) : super(children: _insertGaps(children, gap));

  static List<Widget> _insertGaps(List<Widget> children, double gap) {
    if (children.length < 2) return children;
    return [
      for (int i = 0; i < children.length; i++) ...[
        if (i > 0) SizedBox(width: gap),
        children[i],
      ],
    ];
  }
}

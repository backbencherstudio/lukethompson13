import 'package:flutter/material.dart';
import 'package:lukethompson/presentation/profile/view/widget/shipper_rating_card.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class CircularProgressBar extends StatelessWidget {
  const CircularProgressBar({
    super.key,
    required this.payer,
    required this.rating,
    this.size = 80,
    this.strokeWidth = 8,
  });

  final double rating;
  final PayerCategory payer;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SimpleCircularProgressBar(
      animationDuration: 0,
      progressColors: [payer.color],
      backStrokeWidth: strokeWidth,
      progressStrokeWidth: strokeWidth,
      backColor: Color(0xff313234),
      size: size,
      valueNotifier: ValueNotifier(rating),
      onGetText: (double value) {
        return Text('${value.toInt()}%', style: TextStyle(fontSize: 16));
      },
    );
  }
}

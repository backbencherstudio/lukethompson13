import 'package:flutter/material.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/detention_widget.dart';

class DetentionGrid extends StatelessWidget {
  final List<DetentionData> data;

  const DetentionGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4745762712,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return DetentionWidget(data: data[index]);
      },
    );
  }
}

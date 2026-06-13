import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class FeatureListCard extends StatelessWidget {
  const FeatureListCard({super.key, required this.features});

  final List<String> features;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          width: 1,
          color: Colors.white.withValues(alpha: .15),
        ),
        color: ColorManager.boxColor,
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          ...List.generate(
            features.length,
            (index) => Padding(
              padding: EdgeInsets.only(top: index == 0 ? 0 : 12),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outlined,
                    color: ColorManager.primaryButton,
                  ),
                  8.width,
                  Text(
                    features[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: .w700,
                      letterSpacing: 0.2,
                      color: ColorManager.subtextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.title,
    required this.duration,
    required this.planType,
    required this.price,
    this.titleColor = ColorManager.primaryButton,
    required this.isSelected,
    this.onTap,
  });

  final String title;
  final String duration;
  final String planType;
  final String price;
  final Color titleColor;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.4,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: .all(12.w),
            foregroundDecoration: BoxDecoration(
              border: isSelected
                  ? Border.all(color: ColorManager.primaryButton, width: 2)
                  : null,
              borderRadius: BorderRadius.circular(12.r),
            ),
            decoration: BoxDecoration(
              color: Color(0xff0A0F1A),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 14.sp,
                        fontWeight: .w700,
                      ),
                    ),
                    4.height,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: price,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: .w700,
                            ),
                          ),
                          TextSpan(
                            text: '/$duration',
                            style: TextStyle(
                              color: ColorManager.subtextColor,
                              fontSize: 14,
                              fontWeight: .w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(planType, style: TextStyle(color: Colors.white)),
                  ],
                ),
                if (isSelected)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.check_circle_outlined,
                      color: ColorManager.primaryButton,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

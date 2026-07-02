import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

enum TimelineItemStatus { idle, active, completed }

class TimelineItem extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isLastStep;

  // final bool isConfirmed;
  // final bool isEdited;
  // final bool isEnabled;
  // final bool nextStepConfirmed;

  final ValueChanged<String> onChanged;
  final VoidCallback? onConfirm;
  final TimelineItemStatus status;

  const TimelineItem({
    super.key,
    required this.title,
    required this.controller,
    this.isLastStep = false,
    required this.onChanged,
    this.onConfirm,
    this.status = TimelineItemStatus.idle,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = ColorManager.primaryButton;
    final Color inactiveText = ColorManager.subtextColor;

    final isIdle = status == TimelineItemStatus.idle;
    final isActive = status == TimelineItemStatus.active;
    final isCompleted = status == TimelineItemStatus.completed;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              const SizedBox(width: 20),
              Positioned(
                top: 20,
                child: _buildTimelineDot(isActive: isCompleted),
              ),
              if (!isLastStep)
                Positioned(
                  top: 40,
                  child: Container(
                    width: 2,
                    height: 92,
                    color: isCompleted ? activeColor : inactiveText,
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.labelLarge.copyWith(
                    color: isCompleted
                        ? Colors.white.withValues(alpha: 0.88)
                        : inactiveText,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        onChanged: onChanged,
                        enabled: true,
                        style: TextStyle(
                          color: isCompleted
                              ? Colors.white
                              : isActive
                              ? inactiveText
                              : ColorManager.disabledText,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.access_time,
                            size: 16.sp,
                            color: isActive ? Colors.white70 : inactiveText,
                          ),
                        ),
                      ),
                    ),
                    if (!isCompleted) ...[
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: isActive ? onConfirm : null,
                        child: Container(
                          height: 54,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: isActive
                                ? activeColor
                                : const Color(0xFF1A2028),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              color: isActive
                                  ? Colors.white
                                  : const Color(0xFF17754B),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineDot({required bool isActive}) {
    final Color color = isActive
        ? const Color(0xFF2ECC71)
        : const Color(0xFF738091);

    return Container(
      width: 21,
      height: 21,
      decoration: BoxDecoration(
        color: ColorManager.primary,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Icon(Icons.check, size: 14, color: color),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/activity_indicator.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

enum TimelineItemStatus { idle, active, completed }

class TimelineItem extends StatelessWidget {
  final String label;
  final Widget? labelTail;
  final String? labelHint;
  final bool isLastStep;
  final TimelineItemStatus status;
  final Widget child;
  final bool isActionPending;
  final double lineHeight;

  const TimelineItem({
    super.key,
    required this.label,
    this.labelHint,
    this.isLastStep = false,
    this.status = TimelineItemStatus.idle,
    required this.child,
    required this.isActionPending,
    this.lineHeight = 92,
    this.labelTail,
  });

  @override
  Widget build(BuildContext context) {
    final isIdle = status == TimelineItemStatus.idle;
    final isActive = status == TimelineItemStatus.active;
    final isCompleted = status == TimelineItemStatus.completed;

    final Color statusColor = isActionPending
        ? ColorManager.subtextColor.withValues(alpha: 0.8)
        : isActive
        ? ColorManager.whiteColor
        : isCompleted
        ? ColorManager.primaryButton
        : ColorManager.subtextColor.withValues(alpha: 0.8);

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
                top: 0,
                child: _buildTimelineDot(
                  statusColor,
                  isActive,
                  isCompleted,
                  isActionPending,
                ),
              ),
              if (!isLastStep)
                Positioned(
                  top: 22,
                  child: Container(
                    width: 2,
                    height: lineHeight,
                    color: statusColor,
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    InputLabel(label, color: statusColor, hint: labelHint),
                    ?labelTail,
                  ],
                ),
                SizedBox(height: 8.h),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineDot(
    Color color,
    bool isActive,
    bool isCompleted,
    bool isActionPending,
  ) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: ColorManager.primary,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: isActionPending
          ? ActivityIndicator(radius: 8)
          : Icon(Icons.check, size: 14, color: color),
    );
  }
}

class TimelineContent extends StatefulWidget {
  const TimelineContent({
    super.key,
    required this.value,
    required this.status,
    required this.isActionPending,
    required this.onChanged,
    this.onConfirm,
  });

  final String? value;
  final TimelineItemStatus status;
  final bool isActionPending;
  final ValueChanged<String> onChanged;
  final VoidCallback? onConfirm;

  @override
  State<TimelineContent> createState() => _TimelineContentState();
}

class _TimelineContentState extends State<TimelineContent> {
  DateTime _now = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && widget.status == .active) {
        setState(() => _now = DateTime.now());
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = widget.status == TimelineItemStatus.completed;
    final isActive = widget.status == TimelineItemStatus.active;
    final Color inactiveText = ColorManager.subtextColor;

    final hideActionBtn = isCompleted || !isCompleted && widget.isActionPending;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            height: 54,
            decoration: BoxDecoration(
              color: ColorManager.cardBackground,
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isActive
                      ? DateFormat('hh:mm a').format(_now)
                      : widget.value ?? '00:00',
                  style: TextStyle(
                    color: isCompleted
                        ? Colors.white
                        : isActive
                        ? inactiveText
                        : ColorManager.disabledText,
                  ),
                ),

                Icon(
                  Icons.access_time,
                  size: 16.sp,
                  color: isActive ? Colors.white70 : inactiveText,
                ),
              ],
            ),
          ),
        ),
        if (!hideActionBtn) ...[
          SizedBox(width: 8.w),
          GlobalButton(
            width: 120,
            borderRadius: 8,
            label: widget.isActionPending ? 'Logging..' : 'Confirm',
            onPressed: isActive && !widget.isActionPending
                ? widget.onConfirm
                : null,
          ),
        ],
      ],
    );
  }
}

class TimelineContentField extends StatelessWidget {
  final TextEditingController controller;
  final TimelineItemStatus status;
  final bool isActionPending;
  final bool canSkip;
  final ValueChanged<String> onChanged;
  final VoidCallback? onConfirm;

  const TimelineContentField({
    super.key,
    required this.controller,
    required this.status,
    required this.isActionPending,
    required this.onChanged,
    this.onConfirm,
    this.canSkip = false,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == TimelineItemStatus.completed;
    final isActive = status == TimelineItemStatus.active;
    final Color inactiveText = ColorManager.subtextColor;
    final hideActionBtn = isCompleted || !isCompleted && isActionPending;

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            enabled: isActive && !isActionPending,
            style: TextStyle(
              color: isCompleted
                  ? Colors.white
                  : isActive
                  ? Colors.white
                  : ColorManager.disabledText,
            ),
            decoration: InputDecoration(
              hintStyle: TextStyle(
                color: isActive ? inactiveText : ColorManager.disabledText,
              ),
              hintText: 'Enter BOL number',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              suffixIcon: Icon(
                Icons.description_outlined,
                size: 16.sp,
                color: isActive ? Colors.white70 : inactiveText,
              ),
            ),
          ),
        ),
        if (!hideActionBtn) ...[
          SizedBox(width: 8.w),
          ListenableBuilder(
            listenable: controller,
            builder: (context, _) => GlobalButton(
              width: 120,
              borderRadius: 8,
              label: controller.text.isEmpty && canSkip
                  ? 'Skip'
                  : isActionPending
                  ? 'Logging..'
                  : 'Confirm',
              onPressed: isActive && !isActionPending ? onConfirm : null,
            ),
          ),
        ],
      ],
    );
  }
}

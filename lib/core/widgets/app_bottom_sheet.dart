import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class AppBottomSheet extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? child;
  final Widget? fixedHeader;
  final double headerSpace;
  final double? heightRatio;

  const AppBottomSheet({
    super.key,
    this.title,
    this.subtitle,
    this.child,
    this.fixedHeader,
    this.heightRatio,
    this.headerSpace = 12,
  });

  @override
  Widget build(BuildContext context) {
    final useFixedHeight = heightRatio != null;
    final sheetHeight = useFixedHeight
        ? heightRatio! * MediaQuery.of(context).size.height
        : null;

    final sheet = Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: 15.h,
        top: 12.h,
      ),
      decoration: BoxDecoration(
        color: ColorManager.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      child: Column(
        mainAxisSize: useFixedHeight ? MainAxisSize.max : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: .topCenter,
            children: [
              Align(
                alignment: .centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: const BoxDecoration(
                      color: ColorManager.cardBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: ColorManager.subtextColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Container(
                margin: .only(top: 4),
                width: 48,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          if (title != null) ...[
            Text(
              title!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          if (subtitle != null) ...[
            Text(
              subtitle!,
              style: TextStyle(color: ColorManager.subtextColor, fontSize: 16),
            ),
          ],
          if (fixedHeader != null) ...[
            SizedBox(height: headerSpace),
            fixedHeader!,
          ],
          if (child != null) ...[
            SizedBox(height: headerSpace),
            useFixedHeight
                ? Expanded(child: SingleChildScrollView(child: child!))
                : child!,
          ],
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: useFixedHeight
            ? SizedBox(height: sheetHeight, child: sheet)
            : sheet,
      ),
    );
  }
}

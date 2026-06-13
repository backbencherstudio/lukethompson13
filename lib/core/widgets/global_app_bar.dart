import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class CustomAppBarNew extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppBarNew({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onBack ?? () => Navigator.pop(context),
          child: Image.asset(IconManager.arrowLeft, width: 26.w, height: 24.h),
        ),
        SizedBox(width: 16.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: ColorManager.textColor,
          ),
        ),
      ],
    );
  }
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 48,
        height: 48,
        child: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.chevron_left, size: 28),
          padding: EdgeInsets.zero,
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
    );
  }
}

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool hideBackButton;

  const GlobalAppBar({
    super.key,
    this.title,
    this.actions,
    this.backgroundColor = Colors.transparent,
    this.hideBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool canGoBack = Navigator.of(context).canPop();

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(fontSize: 20.sp, fontWeight: .w700),
      centerTitle: false,
      titleSpacing: 8.w,
      leading: hideBackButton
          ? SizedBox.shrink()
          : canGoBack
          ? Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white12,
                    minimumSize: Size.square(40),
                  ),
                  child: const Icon(Icons.arrow_back_rounded, size: 24),
                ),
              ),
            )
          : null, // Hides the button entirely if it is the first/root screen
      title: title != null ? Text(title!) : null,
      actions: actions,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

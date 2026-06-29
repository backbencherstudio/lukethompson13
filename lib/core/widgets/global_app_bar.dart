import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
          onTap: onBack ?? () => context.pop(),
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
          onPressed: () => context.pop(),
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
  final String? subTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool hideBackButton;
  final bool centerTitle;
  final VoidCallback? onBackPressed;

  const GlobalAppBar({
    super.key,
    this.title,
    this.subTitle,
    this.actions,
    this.backgroundColor = Colors.transparent,
    this.hideBackButton = false,
    this.centerTitle = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool canGoBack = context.canPop();

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(fontSize: 20.sp, fontWeight: .w700),
      centerTitle: centerTitle,
      titleSpacing: 16.w,
      leadingWidth: hideBackButton ? 0 : null,
      leading: hideBackButton
          ? SizedBox.shrink()
          : canGoBack
          ? Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: FilledButton(
                  onPressed: onBackPressed ?? () => context.pop(),
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
      title: Column(
        crossAxisAlignment: .start,
        children: [
          if (title != null) Text(title!),
          if (subTitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                subTitle!,
                style: TextStyle(
                  color: ColorManager.subtextColor,
                  fontSize: 16,
                  fontWeight: .normal,
                ),
              ),
            ),
        ],
      ),
      actions: actions,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

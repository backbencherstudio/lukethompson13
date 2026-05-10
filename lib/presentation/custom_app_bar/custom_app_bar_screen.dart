import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';

class CustomAppBarScreen extends StatelessWidget implements PreferredSizeWidget {
  final String? profileImage;
  final String? welcomeText;
  final String? userName;
  final List<Widget>? actions;
  final Widget? leading;
  final double? height;

  final double? welcomeFontSize;
  final double? userNameFontSize;

  final Color? welcomeTextColor;
  final Color? userNameColor;
  final Color? backgroundColor;

  final FontWeight? welcomeFontWeight;
  final FontWeight? userNameFontWeight;

  const CustomAppBarScreen({
    super.key,
    this.profileImage,
    this.welcomeText,
    this.userName,
    this.actions,
    this.leading,
    this.height,
    this.welcomeFontSize,
    this.userNameFontSize,
    this.welcomeTextColor,
    this.userNameColor,
    this.backgroundColor,
    this.welcomeFontWeight,
    this.userNameFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: leading,
      titleSpacing: leading != null ? 0 : 16.w,
      centerTitle: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (profileImage != null && profileImage!.isNotEmpty) ...[
            CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.grey.shade800,
              backgroundImage: AssetImage(profileImage!),
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (welcomeText != null)
                  Text(
                    welcomeText!,
                    style: TextStyle(
                      color: welcomeTextColor ?? ColorManager.textColor,
                      fontSize: welcomeFontSize ?? 12.sp,
                      fontWeight: welcomeFontWeight ?? FontWeight.w400,
                    ),
                  ),
                
          
                if (welcomeText != null && userName != null) 
                  SizedBox(height: 2.h),

                if (userName != null)
                  Text(
                    userName!,
                    style: TextStyle(
                      color: userNameColor ?? Colors.white,
                      fontSize: userNameFontSize ?? 16.sp,
                      fontWeight: userNameFontWeight ?? FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? (kToolbarHeight + 10.h));
}
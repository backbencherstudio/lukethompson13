import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/app_card.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class TotalClaimedWidget extends StatelessWidget {
  final String title;
  final String amount;
  final Color backgroundColor;
  final Color titleColor;
  final Color amountColor;

  const TotalClaimedWidget({
    super.key,
    this.title = "",
    this.amount = "",
    this.backgroundColor = ColorManager.cardBackground,
    this.titleColor = Colors.white,
    this.amountColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(16),
      backgroundColor: backgroundColor,
      child: Column(
        mainAxisSize: .max,
        crossAxisAlignment: .start,
        mainAxisAlignment: .spaceBetween,
        children: [
          InputLabel(title),
          4.height,
          Text(
            amount,
            style: TextStyle(
              height: 1,
              color: amountColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

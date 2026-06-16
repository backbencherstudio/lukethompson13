import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class SetYourRateScreen extends StatefulWidget {
  const SetYourRateScreen({super.key});

  @override
  State<SetYourRateScreen> createState() => _SetYourRateScreenState();
}

class _SetYourRateScreenState extends State<SetYourRateScreen> {
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _rateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(title: 'Set Your Rate'),
      body: AppGradientBackground(
        child: SafeArea(
          child: FullHeightScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),

                InputLabel("Your Hourly Rate"),
                SizedBox(height: 8.h),
                CustomTextFieldWidget(
                  hintText: "\$50",
                  controller: _rateController,
                ),

                SizedBox(height: 16.h),

                InputLabel("Free Wait Time"),
                SizedBox(height: 8.h),
                CustomTextFieldWidget(
                  hintText: "2",
                  controller: _timeController,
                ),

                SizedBox(height: 6.h),

                Text(
                  "*Hours before detention changes apply",
                  style: TextStyle(
                    color: ColorManager.subtextColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const Spacer(),
                SizedBox(height: 40.h),
                GlobalButton(label: "Save Changes", onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

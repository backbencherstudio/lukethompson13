import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/network/error_handle.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/data/providers/user_queries.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class SetYourRateScreen extends ConsumerStatefulWidget {
  const SetYourRateScreen({super.key});

  @override
  ConsumerState<SetYourRateScreen> createState() => _SetYourRateScreenState();
}

class _SetYourRateScreenState extends ConsumerState<SetYourRateScreen> {
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _rateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _populateTextControllers(User? user) {
    final ratePerHourame = user?.ratePerHour;
    final freeWaitTime = user?.freeWaitTime;
    if (ratePerHourame != null &&
        ratePerHourame.toString() != _rateController.text) {
      _rateController.text = ratePerHourame.toString();
    }

    if (freeWaitTime != null &&
        freeWaitTime.toString() != _timeController.text) {
      _timeController.text = freeWaitTime.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    _populateTextControllers(ref.read(userQuery).asData?.value);
  }

  Future<void> _handleUpdate() async {
    final rate = int.tryParse(_rateController.text.trim());
    final freeWaitTime = int.tryParse(_timeController.text.trim());

    final ctx = context;
    final action = ref.read(updateUserProfileMutation);

    try {
      final response = await action.run(
        UpdateUserProfileParams(ratePerHour: rate, freeWaitTime: freeWaitTime),
      );

      if (!ctx.mounted) return;

      if (response.success) {
        ref.invalidate(userQuery);
        ctx.pop();
      }

      ctx.showResultSnackBar(
        response.success
            ? 'Rate updated successfully'
            : 'Failed to update rate',
        isSuccess: response.success,
        subtitle: response.success ? null : response.message,
      );
    } catch (e) {
      ctx.showResultSnackBar(ErrorHandle.formatErrorMessage(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(title: 'Set Your Rate'),
      body: AppGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
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
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: 16.h),

                InputLabel("Free Wait Time"),
                SizedBox(height: 8.h),
                CustomTextFieldWidget(
                  hintText: "2",
                  controller: _timeController,
                  keyboardType: TextInputType.number,
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
              ],
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: .centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
        child: GlobalButton(label: "Save Changes", onPressed: _handleUpdate),
      ),
    );
  }
}

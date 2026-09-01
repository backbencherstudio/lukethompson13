import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/resource/utils.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfileFormStep1 extends StatelessWidget {
  const ProfileFormStep1({
    super.key,
    required this.userName,
    required this.phoneNumber,
    // required this.email,
    required this.onSubmit,
  });

  final FormControl<String> userName;
  final FormControl<String> phoneNumber;
  // final FormControl<String> email;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return FullHeightScrollView(
      padding: EdgeInsets.only(
        left: AppPadding.screenPadding,
        right: AppPadding.screenPadding,
        bottom: Utils.bottomPaddingInset(context),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const InputLabel('Your Name'),
          SizedBox(height: 8.h),
          ReactiveTextField<String>(
            autofocus: true,
            formControl: userName,
            textInputAction: TextInputAction.next,
            validationMessages: {
              ValidationMessage.required: (_) => 'name is required',
            },
            decoration: const InputDecoration(hintText: 'Enter your full name'),
          ),
          SizedBox(height: 16.h),

          const InputLabel('Phone Number'),
          SizedBox(height: 8.h),
          ReactiveTextField<String>(
            formControl: phoneNumber,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validationMessages: {
              ValidationMessage.required: (_) => 'Phone number is required',
            },
            decoration: const InputDecoration(hintText: 'Enter phone number'),
          ),

          SizedBox(height: 16.h),

          // const InputLabel('Email Address'),
          // SizedBox(height: 8.h),
          // ReactiveTextField<String>(
          //   formControl: email,
          //   keyboardType: TextInputType.emailAddress,
          //   textInputAction: TextInputAction.done,
          //   validationMessages: {
          //     ValidationMessage.required: (_) => 'Email address is required',
          //     ValidationMessage.email: (_) => 'Enter a valid email address',
          //   },
          //   decoration: const InputDecoration(hintText: 'Enter email address'),
          // ),
          Spacer(),
          16.height,
          ReactiveFormConsumer(
            builder: (_, form, _) {
              return GlobalButton(
                isDisabled: !form.valid,
                label: 'Save & Continue',
                onPressed: onSubmit,
              );
            },
          ),
        ],
      ),
    );
  }
}

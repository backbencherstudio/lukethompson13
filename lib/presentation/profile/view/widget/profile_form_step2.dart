import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/sizedbox_extension.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfileFormStep2 extends StatelessWidget {
  const ProfileFormStep2({
    super.key,
    required this.companyName,
    required this.contactName,
    required this.companyPhone,
    required this.addressLine1,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.onSubmit,
    this.companyNameFocusNode,
  });

  final FormControl<String> companyName;
  final FormControl<String> contactName;
  final FormControl<String> companyPhone;
  final FormControl<String> addressLine1;
  final FormControl<String> city;
  final FormControl<String> state;
  final FormControl<String> postalCode;
  final FormControl<String> country;
  final VoidCallback onSubmit;
  final FocusNode? companyNameFocusNode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const InputLabel('Company Name'),
          SizedBox(height: 8.h),
          ReactiveTextField<String>(
            focusNode: companyNameFocusNode,
            formControl: companyName,
            textInputAction: TextInputAction.next,
            validationMessages: {
              ValidationMessage.required: (_) => 'Company name is required',
            },
            decoration: const InputDecoration(
              hintText: 'Enter your company name',
            ),
          ),

          SizedBox(height: 16.h),

          const InputLabel('Contact Name'),
          SizedBox(height: 8.h),
          ReactiveTextField<String>(
            formControl: contactName,
            textInputAction: TextInputAction.next,
            validationMessages: {
              ValidationMessage.required: (_) => 'Contact person’s name',
            },
            decoration: const InputDecoration(
              hintText: 'Enter contact person’s name',
            ),
          ),

          SizedBox(height: 16.h),

          const InputLabel('Company Phone'),
          SizedBox(height: 8.h),
          ReactiveTextField<String>(
            formControl: companyPhone,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validationMessages: {
              ValidationMessage.required: (_) => 'Company phone is required',
            },
            decoration: const InputDecoration(
              hintText: 'Enter company phone number',
            ),
          ),

          SizedBox(height: 16.h),

          const InputLabel('Mailing Address'),
          SizedBox(height: 8.h),

          const InputLabel('Address', color: Colors.white70),
          SizedBox(height: 4.h),
          ReactiveTextField<String>(
            formControl: addressLine1,
            textInputAction: TextInputAction.next,
            validationMessages: {
              ValidationMessage.required: (_) => 'Address line is required',
            },
            decoration: const InputDecoration(hintText: 'Enter street address'),
          ),

          SizedBox(height: 12.h),

          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InputLabel('City', color: Colors.white70),
                    SizedBox(height: 4.h),
                    ReactiveTextField<String>(
                      formControl: city,
                      textInputAction: TextInputAction.next,
                      validationMessages: {
                        ValidationMessage.required: (_) => 'City is required',
                      },
                      decoration: const InputDecoration(hintText: 'Enter city'),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InputLabel('State', color: Colors.white70),
                    SizedBox(height: 4.h),
                    ReactiveTextField<String>(
                      formControl: state,
                      textInputAction: TextInputAction.next,
                      validationMessages: {
                        ValidationMessage.required: (_) => 'State is required',
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter state',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InputLabel('Postal Code', color: Colors.white70),
                    SizedBox(height: 4.h),
                    ReactiveTextField<String>(
                      formControl: postalCode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                            'Postal code is required',
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter postal code',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InputLabel('Country', color: Colors.white70),
                    SizedBox(height: 4.h),
                    ReactiveTextField<String>(
                      formControl: country,
                      textInputAction: TextInputAction.done,
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                            'Country is required',
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter country',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          16.height,
          ReactiveFormConsumer(
            builder: (_, form, _) {
              return GlobalButton(
                isDisabled: !form.valid,
                label: 'Save',
                onPressed: onSubmit,
              );
            },
          ),
        ],
      ),
    );
  }
}

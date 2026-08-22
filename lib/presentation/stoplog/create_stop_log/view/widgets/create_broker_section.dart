import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateBrokerSection extends StatelessWidget {
  const CreateBrokerSection({
    super.key,
    required this.brokerNameControl,
    required this.brokerEmailControl,
    required this.onSelectPress,
  });

  final FormControl<String> brokerNameControl;
  final FormControl<String> brokerEmailControl;
  final VoidCallback onSelectPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const InputLabel('Broker Name'),
            TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              onPressed: onSelectPress,
              child: Row(
                children: [
                  Text(
                    "Select Broker",
                    style: TextStyle(color: ColorManager.primaryButton),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: ColorManager.primaryButton,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        ReactiveTextField<String>(
          formControl: brokerNameControl,
          decoration: const InputDecoration(hintText: 'Enter broker name'),
        ),

        SizedBox(height: 8.h),
        const InputLabel('Broker Email'),
        ReactiveTextField<String>(
          formControl: brokerEmailControl,
          validationMessages: {
            ValidationMessage.email: (_) => 'Please enter a valid email',
          },
          decoration: const InputDecoration(hintText: 'Enter broker Email'),
        ),
      ],
    );
  }
}

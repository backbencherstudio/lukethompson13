import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/extensions/text_style_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/widgets/tinted_outlined_button.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/facility_search_sheet.dart';

class CreateBrokerSection extends StatefulWidget {
  const CreateBrokerSection({super.key});

  @override
  State<CreateBrokerSection> createState() => _CreateBrokerSectionState();
}

class _CreateBrokerSectionState extends State<CreateBrokerSection> {
  late final _facilityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: .start,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text("Broker Name", style: context.labelLarge),
            TextButton(
              style: TextButton.styleFrom(padding: .zero),
              onPressed: () {
                showFacilitySearchSheet(context);
              },
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
        CustomTextFieldWidget(
          hintText: "Enter broker name",
          controller: _facilityNameController,
          autofocus: true,
          keyboardType: TextInputType.text,
          textInputAction: .next,
        ),

        SizedBox(height: 8.h),
        Text("Broker Email", style: context.labelLarge),
        CustomTextFieldWidget(
          hintText: "Enter broker Email",
          controller: _facilityNameController,
          autofocus: true,
          keyboardType: TextInputType.text,
          textInputAction: .next,
        ),
      ],
    );
  }
}

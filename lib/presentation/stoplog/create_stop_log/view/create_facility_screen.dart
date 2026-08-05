import 'package:flutter/material.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';
import 'package:lukethompson/presentation/stoplog/create_stop_log/view/widgets/create_facility_mapview.dart';

class CreateFacilityScreen extends StatefulWidget {
  const CreateFacilityScreen({super.key});

  @override
  State<CreateFacilityScreen> createState() => _CreateFacilityScreenState();
}

class _CreateFacilityScreenState extends State<CreateFacilityScreen> {
  late final TextEditingController _facilityNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(
        title: 'Create facility',
        // subTitle: session.value?.address,
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: Column(
            spacing: 12,
            children: [
              Expanded(child: CreateFacilityMapview()),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.screenPadding,
                ),
                child: Column(
                  spacing: 12,
                  children: [
                    CustomTextFieldWidget(
                      hintText: "Enter facility name",
                      controller: _facilityNameController,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      textInputAction: .next,
                    ),
                    CustomTextFieldWidget(
                      hintText: "Search facility location",
                      controller: _facilityNameController,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      textInputAction: .next,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

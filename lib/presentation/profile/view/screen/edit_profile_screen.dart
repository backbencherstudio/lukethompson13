import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/full_height_scroll_view.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(title: 'Edit Profile'),
      body: AppGradientBackground(
        child: SafeArea(
          child: FullHeightScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),

                InputLabel("Full Name"),
                SizedBox(height: 8.h),
                CustomTextFieldWidget(
                  hintText: "Enter your full name",
                  controller: _nameController,
                ),

                SizedBox(height: 16.h),

                InputLabel("Email Address"),
                SizedBox(height: 8.h),
                CustomTextFieldWidget(
                  hintText: "Enter your email address",
                  controller: _emailController,
                ),

                SizedBox(height: 16.h),

                InputLabel("Phone Number"),
                SizedBox(height: 8.h),
                CustomTextFieldWidget(
                  hintText: "Enter your phone number",
                  controller: _phoneController,
                ),

                const Spacer(),
                SizedBox(height: 40.h),

                GlobalButton(
                  label: "Update",
                  onPressed: () {
                    print("Name: ${_nameController.text}");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

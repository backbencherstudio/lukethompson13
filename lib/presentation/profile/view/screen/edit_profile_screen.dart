import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/data/models/models.dart';
import 'package:lukethompson/data/providers/user_queries.dart';
import 'package:lukethompson/presentation/custom_widget/textField_widget.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _populateTextControllers(User? user) {
    final name = user?.name;
    final phoneNumber = user?.phoneNumber;
    if (name != null && name != _nameController.text) {
      _nameController.text = name;
    }
    if (phoneNumber != null && phoneNumber != _phoneController.text) {
      _phoneController.text = phoneNumber;
    }
  }

  @override
  void initState() {
    super.initState();
    _populateTextControllers(ref.read(userQuery).asData?.value);
  }

  Future<void> _handleUpdate() async {
    final ctx = context;
    final action = ref.read(updateUserProfileMutation);

    final response = await action.run(
      UpdateUserProfileParams(
        name: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
      ),
    );

    if (!ctx.mounted) return;

    if (response.success) {
      ref.invalidate(userQuery);
      ctx.pop();
    }

    ctx.showResultSnackBar(
      response.success
          ? 'Profile updated successfully'
          : 'Failed to update profile',
      isSuccess: response.success,
      subtitle: response.success ? null : response.message,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userQuery, (prev, next) {
      next.whenData(_populateTextControllers);
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(title: 'Edit Profile'),
      body: AppGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
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

                // SizedBox(height: 16.h),
                // InputLabel("Email Address"),
                // SizedBox(height: 8.h),
                // CustomTextFieldWidget(
                //   hintText: "Enter your email address",
                //   controller: _emailController,
                // ),
                SizedBox(height: 16.h),

                InputLabel("Phone Number"),
                SizedBox(height: 8.h),
                CustomTextFieldWidget(
                  hintText: "Enter your phone number",
                  controller: _phoneController,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: .centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
        child: GlobalButton(label: "Update", onPressed: _handleUpdate),
      ),
    );
  }
}

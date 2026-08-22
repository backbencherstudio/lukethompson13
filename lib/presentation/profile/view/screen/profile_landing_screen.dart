import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lukethompson/core/extensions/snackbar_extension.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/config.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/custom_dialog.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/global_button.dart';
import 'package:lukethompson/core/widgets/profile_header.dart';
import 'package:lukethompson/core/widgets/profile_setting_item.dart';
import 'package:lukethompson/core/widgets/section_header.dart';
import 'package:lukethompson/data/sources/remote/remote.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlobalAppBar(
        title: 'Profile',
        hideBackButton: true,
        centerTitle: true,
      ),
      body: AppGradientBackground(
        child: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(userQuery);
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.screenPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 12),
                      const ProfileImage(),
                      const SizedBox(height: 32),
                      SectionHeader(title: 'Profile Setting', fontSize: 16),

                      const SizedBox(height: 15),
                      ProfileSettingItem(
                        icon: Icons.person_outline,
                        title: "Edit Profile",
                        onTap: () => context.push(Routes.editProfile),
                      ),
                      ProfileSettingItem(
                        icon: Icons.attach_money,
                        title: "Set Your Rate",
                        onTap: () => context.push(Routes.setRate),
                      ),
                      ProfileSettingItem(
                        icon: Icons.assignment_outlined,
                        title: "My Claims",
                        onTap: () => context.push(Routes.myClaims),
                      ),
                      ProfileSettingItem(
                        icon: Icons.stars_outlined,
                        title: "Broker & Doc Scores",
                        onTap: () => context.push(Routes.shipperRatings),
                      ),

                      if (AppConfig.isRevenueCatEnabled)
                        ProfileSettingItem(
                          icon: Icons.workspace_premium_outlined,
                          title: "Subscriptions",
                          onTap: () => context.push(Routes.manageSubscription),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorManager.primaryButton,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Upgrade Plan",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white38,
                                size: 16,
                              ),
                            ],
                          ),
                        ),

                      ProfileSettingItem(
                        icon: Icons.lock_outline,
                        title: "Privacy & policy",
                        onTap: () => context.push(Routes.privacyAndPolicy),
                      ),
                      ProfileSettingItem(
                        icon: Icons.help_outline,
                        title: "Help & Support",
                        onTap: () => context.push(Routes.helpAndSupport),
                      ),
                      buildDeleteAccoutItem(),
                      buildLoutItem(),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Consumer buildDeleteAccoutItem() {
    return Consumer(
      builder: (context, ref, _) => ProfileSettingItem(
        icon: Icons.person,
        title: "Delete Account",
        titleColor: Colors.redAccent,
        iconColor: Colors.redAccent,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: 'Delete Account',
              subtitle: 'Are you sure you want to delete your account?',
              bottomWidget: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: GlobalButton.primary(
                      label: 'Delete Account',
                      onPressed: () {
                        context.go(Routes.signIn);
                      },
                    ),
                  ),
                  Expanded(
                    child: GlobalButton.outlined(
                      label: 'Cancel',
                      onPressed: () => context.pop(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Consumer buildLoutItem() {
    return Consumer(
      builder: (context, ref, _) => ProfileSettingItem(
        icon: Icons.logout,
        title: "Log Out",
        iconColor: Colors.redAccent,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: 'Log Out',
              subtitle: 'Are you sure you want to log out?',
              bottomWidget: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: GlobalButton.primary(
                      label: 'Log Out',
                      onPressed: () {
                        ref.read(authStateProvider.notifier).logout();
                        context.go(Routes.signIn);
                      },
                    ),
                  ),
                  Expanded(
                    child: GlobalButton.outlined(
                      label: 'Cancel',
                      onPressed: () => context.pop(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileImage extends ConsumerStatefulWidget {
  const ProfileImage({super.key});

  @override
  ConsumerState<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends ConsumerState<ProfileImage> {
  Future<void> _handleImageChange() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null || !mounted) return;

    final action = ref.read(updateUserProfileMutation);
    final response = await action.run(
      UpdateUserProfileParams(image: File(picked.path)),
    );

    if (!mounted) return;

    if (response.success) {
      ref.invalidate(userQuery);
      context.showSuccessSnackBar('Avatar updated successfully');
    } else {
      context.showErrorSnackBar(response.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userQuery);

    return ProfileHeader(
      name: userAsync.asData?.value?.name ?? '',
      email: userAsync.asData?.value?.email ?? '',
      avatarUrl: userAsync.asData?.value?.avatar,
      onChangePressed: _handleImageChange,
    );
  }
}

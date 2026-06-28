import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_app_bar.dart';
import 'package:lukethompson/core/widgets/profile_header.dart';
import 'package:lukethompson/core/widgets/profile_setting_item.dart';
import 'package:lukethompson/core/widgets/section_header.dart';
import 'package:lukethompson/data/repositories/auth_provider.dart';

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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                const ProfileHeader(
                  name: 'Kristin Rodriguez',
                  email: 'Kristin@untitledui.com',
                  avatarUrl: 'https://i.pravatar.cc/300',
                ),
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
                  title: "Shipper Ratings",
                  onTap: () => context.push(Routes.shipperRatings),
                ),
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
                Consumer(
                  builder: (context, ref, _) => ProfileSettingItem(
                    icon: Icons.logout,
                    title: "Log Out",
                    iconColor: Colors.redAccent,
                    onTap: () {
                      ref.read(authProvider.notifier).logout();
                      context.go(Routes.signIn);
                    },
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

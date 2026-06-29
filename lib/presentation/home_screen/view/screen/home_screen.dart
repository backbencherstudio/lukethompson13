import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/resource/constants/image_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/data/providers/user_query_provider.dart';
import 'package:lukethompson/presentation/custom_app_bar/custom_app_bar_screen.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/carusel_slider.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/tab_bar.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/unlock_dialog.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});

  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 15), () {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => UnlockDialog(
            onSubscribe: () {
              context.push(Routes.chooseSubscriptionPlan);
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userQuery);
    final userName = userAsync.asData?.value?.name ?? "--";

    return AppGradientBackground(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: CustomAppBarScreen(
          userName: userName,
          welcomeText: "Welcome Back",
          profileImage: ImageManager.user,
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              CustomCarouselSlider(),
              SizedBox(height: 12.h),
              const Expanded(child: CustomTabScreen()),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lukethompson/core/resource/constants/image_manager.dart';
import 'package:lukethompson/core/resource/constants/values_manager.dart';
import 'package:lukethompson/core/route/route_names.dart';
import 'package:lukethompson/core/widgets/app_gradient_background.dart';
import 'package:lukethompson/core/widgets/global_tab_bar.dart';
import 'package:lukethompson/data/sources/remote/auth/user_queries.dart';
import 'package:lukethompson/presentation/custom_app_bar/custom_app_bar_screen.dart';
import 'package:lukethompson/presentation/home_screen/view/screen/home_tab_bar_view_item.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/carusel_slider.dart';
import 'package:lukethompson/presentation/home_screen/view/widget/unlock_dialog.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});

  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    Future.delayed(const Duration(seconds: 15), () {
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userQuery);
    final userName = userAsync.asData?.value?.name ?? "-";

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
          child: NestedScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(child: CustomCarouselSlider()),
              SliverToBoxAdapter(child: SizedBox(height: 12.h)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.screenPadding,
                  ),
                  child: GlobalTabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Today'),
                      Tab(text: 'Weekly'),
                    ],
                  ),
                ),
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                HomeTabBarViewItem(period: .today),
                HomeTabBarViewItem(period: .week),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

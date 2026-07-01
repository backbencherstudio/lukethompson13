import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lukethompson/core/resource/constants/color_manager.dart';
import 'package:lukethompson/core/resource/constants/icon_manager.dart';
import 'package:lukethompson/presentation/home_screen/view/screen/home_screen.dart';
import 'package:lukethompson/presentation/log_screen/view/screen/log_screen.dart';
import 'package:lukethompson/presentation/profile/view/screen/profile_landing_screen.dart';
import 'package:lukethompson/presentation/reports/view/screen/reports_screen.dart';
import 'package:lukethompson/presentation/stops/view/screen/stops_screen.dart';

class ParentScreenNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void goTo(int index) => state = index;
  void goToHome() => goTo(0);
  void goToStops() => goTo(1);
  void goToLog() => goTo(2);
  void goToReports() => goTo(3);
  void goToProfile() => goTo(4);
}

final parentScreenIndexProvider = NotifierProvider<ParentScreenNotifier, int>(
  ParentScreenNotifier.new,
);

class ParentScreen extends ConsumerStatefulWidget {
  const ParentScreen({super.key});

  @override
  ConsumerState<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends ConsumerState<ParentScreen> {
  final List<Widget> _screens = [
    Homescreen(),
    StopsScreen(),
    LogScreen(),
    ReportsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectIndex = ref.watch(parentScreenIndexProvider);

    return Scaffold(
      body: IndexedStack(index: selectIndex, children: _screens),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        decoration: const BoxDecoration(
          color: ColorManager.primary,
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, IconManager.home, 'Home', selectIndex),
            _buildNavItem(1, IconManager.stops, 'Stops', selectIndex),
            _buildAddButton(2),
            _buildNavItem(3, IconManager.reports, 'Report', selectIndex),
            _buildNavItem(4, IconManager.profile, 'Profile', selectIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String icon, String label, int currentIndex) {
    final isSelected = currentIndex == index;

    final color = isSelected
        ? ColorManager.primaryButton
        : ColorManager.greyText;

    return InkWell(
      onTap: () => _onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(icon, color: color, width: 24.w, height: 24.h),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(int index) =>
      ref.read(parentScreenIndexProvider.notifier).goTo(index);

  Widget _buildAddButton(int index) {
    return InkWell(
      onTap: () => _onTap(index),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: ColorManager.primaryButton,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: ColorManager.primaryButton.withValues(alpha: 0.3),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  final Color color;
  const _PlaceholderScreen({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withValues(alpha: 0.1),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

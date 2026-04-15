import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:lukethompson/presentation/home_screen/view/screen/homeScreen.dart';


class AppColors {
  static const Color primaryGreen = Color(0xFF39D37C); 
  static const Color navBackground = Color(0xFF0D151C); 
  static const Color unselectedGrey = Color(0xFF7B8794);
}


final parentScreenIndexProvider = StateProvider<int>((ref) => 0);

class ParentScreen extends ConsumerStatefulWidget {
  const ParentScreen({super.key});

  @override
  ConsumerState<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends ConsumerState<ParentScreen> {
 
  
  final List<Widget> _screens = [
    Homescreen(),
    const _PlaceholderScreen(title: "Stops Screen", color: Colors.indigo),
    const _PlaceholderScreen(title: "Add New Item (Plus Button)", color: Colors.green),
    const _PlaceholderScreen(title: "Report Screen", color: Colors.teal),
    const _PlaceholderScreen(title: "Profile Screen", color: Colors.brown),
  ];

  @override
  Widget build(BuildContext context) {
    final selectIndex = ref.watch(parentScreenIndexProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF131A23),
      body: IndexedStack(
        index: selectIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 20), 
        decoration: const BoxDecoration(
          color: AppColors.navBackground,
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
        
            _buildNavItem(0, Icons.home_filled, 'Home', selectIndex),
            
    
            _buildNavItem(1, Icons.location_on, 'Stops', selectIndex),
            
       
            _buildAddButton(2),

          
            _buildNavItem(3, Icons.assignment, 'Report', selectIndex),
            
            _buildNavItem(4, Icons.person, 'Profile', selectIndex),
          ],
        ),
      ),
    );
  }

 
  Widget _buildNavItem(int index, IconData icon, String label, int currentIndex) {
    final isSelected = currentIndex == index;
  
    final color = isSelected ? AppColors.primaryGreen : AppColors.unselectedGrey;

    return InkWell(
      onTap: () => ref.read(parentScreenIndexProvider.notifier).state = index,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 28),
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


  Widget _buildAddButton(int index) {
    return InkWell(
      onTap: () {
        ref.read(parentScreenIndexProvider.notifier).state = index;
      },
      borderRadius: BorderRadius.circular(30), 
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: AppColors.primaryGreen, 
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryGreen.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
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
      color: color.withOpacity(0.1),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
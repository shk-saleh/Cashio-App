import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SalomonBottomBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        backgroundColor: Colors.transparent,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(LucideIcons.house, size: 20.0,),
            title: const Text("Home"),
            selectedColor: Colors.orangeAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(LucideIcons.chartArea, size: 20.0,),
            title: const Text("Analytics"),
            selectedColor: Colors.orangeAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(LucideIcons.plus, size: 20.0,),
            title: const Text("Add"),
            selectedColor: Colors.orangeAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(LucideIcons.list, size: 20.0,),
            title: const Text("Transactions"),
            selectedColor: Colors.orangeAccent,
          ),

          SalomonBottomBarItem(
            icon: const Icon(LucideIcons.user, size: 20.0,),
            title: const Text("Account"),
            selectedColor: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}

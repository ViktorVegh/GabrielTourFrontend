import 'package:flutter/material.dart';

class SelectableBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;

  SelectableBottomNavbar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Color(0xFFE4733A),
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(color: Color(0xFFE4733A), size: 45),
      unselectedIconTheme: IconThemeData(color: Colors.grey, size: 40),
      items: items,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/widgets/selectable_bottom_navbar.dart';

class UserNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const UserNavbar({required this.currentIndex, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            color: const Color.fromARGB(255, 158, 158, 158),
            thickness: 1,
            height: 1,
          ),
        ),
        SelectableBottomNavbar(
          currentIndex: currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                size: 30,
                color: currentIndex == 0
                    ? Color.fromARGB(255, 166, 94, 43)
                    : Colors.grey,
              ),
              label: 'Správy',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.airplane_ticket,
                size: 30,
                color: currentIndex == 1
                    ? Color.fromARGB(255, 166, 94, 43)
                    : Colors.grey,
              ),
              label: 'Môj zájazd',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
                color: currentIndex == 2
                    ? Color.fromARGB(255, 166, 94, 43)
                    : Colors.grey,
              ),
              label: 'Profil',
            ),
          ],
        ),
      ],
    );
  }
}

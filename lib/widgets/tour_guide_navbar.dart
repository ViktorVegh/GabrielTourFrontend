import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gabriel_tour_app/widgets/selectable_bottom_navbar.dart';

class TourGuideNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  TourGuideNavbar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SelectableBottomNavbar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/navbar/my_trip_icon.svg',
            colorFilter: ColorFilter.mode(
              currentIndex == 0 ? Color(0xFFE4733A) : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: 'Zájazdy',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/navbar/message_icon.svg',
            colorFilter: ColorFilter.mode(
              currentIndex == 1 ? Color(0xFFE4733A) : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: 'Správy',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/navbar/profile_icon.svg',
            colorFilter: ColorFilter.mode(
              currentIndex == 2 ? Color(0xFFE4733A) : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          label: 'Profil',
        ),
      ],
    );
  }
}

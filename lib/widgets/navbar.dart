import 'package:flutter/material.dart';

class UserNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0, // Index of selected item
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/navbar/search_trip_icon.svg',
              height: 30),
          label: 'Vyhľadaj zájazdy',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/navbar/my_trip_icon.svg', height: 30),
          label: 'Môj zájazd',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/navbar/message_icon.svg', height: 30),
          label: 'Správy',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/navbar/profile_icon.svg', height: 30),
          label: 'Profil',
        ),
      ],
    );
  }
}

class TourGuideNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/navbar/message_icon.svg', height: 30),
          label: 'Správy',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/navbar/profile_icon.svg', height: 30),
          label: 'Profil',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/navbar/search_trip_icon.svg',
              height: 30),
          label: 'Zájazdy',
        ),
      ],
    );
  }
}

class DriverNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/navbar/message_icon.svg', height: 30),
          label: 'Správy',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/navbar/profile_icon.svg', height: 30),
          label: 'Profil',
        ),
        BottomNavigationBarItem(
          icon:
              Image.asset('assets/icons/navbar/calendar_icon.svg', height: 30),
          label: 'Kalendár',
        ),
      ],
    );
  }
}

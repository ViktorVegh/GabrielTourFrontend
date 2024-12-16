import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/widgets/user_navbar.dart';
import 'package:gabriel_tour_app/widgets/tour_guide_navbar.dart';
import 'package:gabriel_tour_app/widgets/driver_navbar.dart';

class RoleSpecificNavbar extends StatefulWidget {
  final String role;
  final int initialIndex;
  final Widget child;

  RoleSpecificNavbar(
      {required this.role, required this.child, required this.initialIndex});

  @override
  _RoleSpecificNavbarState createState() => _RoleSpecificNavbarState();
}

class _RoleSpecificNavbarState extends State<RoleSpecificNavbar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (widget.role) {
      case 'user':
        _navigateUser(index);
        break;
      case 'tourguide':
        _navigateTourGuide(index);
        break;
      case 'driver':
        _navigateDriver(index);
        break;
    }
  }

  void _navigateUser(int index) {
    switch (index) {
      case 0: // My Trip
        Navigator.pushReplacementNamed(context, '/myTrips');
        break;
      case 1: // Messages
        Navigator.pushReplacementNamed(context, '/messages');
        break;
      case 2: // Profile
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      default:
        throw Exception("Invalid index for user navbar: $index");
    }
  }

  // Navigation logic for tour guide
  void _navigateTourGuide(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/tourGuideTrips');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/tourGuideMessages');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/tourGuideProfile');
        break;
    }
  }

  // Navigation logic for driver
  void _navigateDriver(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/driverCalendar');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/driverMessages');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/driverProfile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bottomNavbar;

    // navbar based on role
    switch (widget.role) {
      case 'user':
        bottomNavbar = UserNavbar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        );
        break;
      case 'tourguide':
        bottomNavbar = TourGuideNavbar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        );
        break;
      case 'driver':
        bottomNavbar = DriverNavbar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        );
        break;
      default:
        bottomNavbar = UserNavbar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        );
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: bottomNavbar,
    );
  }
}

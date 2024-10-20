import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/widgets/user_navbar.dart';
import 'package:gabriel_tour_app/widgets/tour_guide_navbar.dart';
import 'package:gabriel_tour_app/widgets/driver_navbar.dart';

class RoleSpecificNavbar extends StatefulWidget {
  final String role;
  final int initialIndex; // Add initialIndex to track the correct initial tab
  final Widget child;

  RoleSpecificNavbar(
      {required this.role, required this.child, required this.initialIndex});

  @override
  _RoleSpecificNavbarState createState() => _RoleSpecificNavbarState();
}

class _RoleSpecificNavbarState extends State<RoleSpecificNavbar> {
  int _currentIndex = 0; // Default value

  @override
  void initState() {
    super.initState();
    _currentIndex =
        widget.initialIndex; // Set the initial index from the screen
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected index when a tab is tapped
    });

    // Perform navigation based on the role and the selected tab
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

  // Navigation logic for user
  void _navigateUser(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/searchTrips');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/myTrips');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/messages');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
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

    // Render correct navbar based on role
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

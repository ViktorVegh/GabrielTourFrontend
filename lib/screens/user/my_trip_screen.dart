import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/widgets/role_specific_navbar.dart';

class MyTripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoleSpecificNavbar(
      role: 'user',
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Môj zájazd'),
        ),
        body: Center(
          child: Text('Toto je obrazovka s výletmi pre zákazníka'),
        ),
      ),
    );
  }
}

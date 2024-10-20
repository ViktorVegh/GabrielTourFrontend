import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/widgets/role_specific_navbar.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoleSpecificNavbar(
      role: 'driver',
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Kalendár'),
        ),
        body: Center(
          child: Text('Toto je obrazovka s kalendárom pre vodiča.'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/widgets/role_specific_navbar.dart';

class TripsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RoleSpecificNavbar(
      role: 'tourguide',
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Zájazdy za ktoré je zodpovedný delegát'),
        ),
        body: Center(
          child: Text('Toto je obrazovka so zájazdmi pre delegáta.'),
        ),
      ),
    );
  }
}

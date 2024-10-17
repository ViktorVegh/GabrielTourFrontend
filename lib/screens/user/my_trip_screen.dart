import 'package:flutter/material.dart';

class MyTripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Môj zájazd'),
      ),
      body: Center(
        child: Text('Toto je obrazovka s výletmy pre zákazníka'),
      ),
    );
  }
}

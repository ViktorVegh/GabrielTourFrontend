import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalenár'),
      ),
      body: Center(
        child: Text('Toto je obrazovka s kalendárom pre vodiča.'),
      ),
    );
  }
}

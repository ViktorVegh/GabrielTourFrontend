import 'package:flutter/material.dart';

class TripsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zájazdy za ktoré je zodpovedný delegát'),
      ),
      body: Center(
        child: Text('Toto je obrazovka so zájazdmi pre delegáta.'),
      ),
    );
  }
}

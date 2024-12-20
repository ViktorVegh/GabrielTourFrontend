import 'package:flutter/material.dart';

class OfficeWebDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Office Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/office');
              },
              child: Text('Create Tee Time'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Manage Drivers'),
            ),
          ],
        ),
      ),
    );
  }
}

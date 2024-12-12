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
                Navigator.pushNamed(context, '/office'); // Navigate to Create Tee Time
              },
              child: Text('Create Tee Time'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add navigation for other office functionalities
              },
              child: Text('Manage Drivers'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/screens/office/tee_time_create.dart';
import 'package:gabriel_tour_app/screens/office/tee_time_delete.dart';
import 'package:gabriel_tour_app/screens/office/tee_time_edit.dart';

class OfficeWebDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Office Dashboard'),
      ),
      body: screenWidth > 800
          ? Row(
              children: [
                Expanded(
                  flex: 2,
                  child: NavigationPanel(),
                ),
                Expanded(
                  flex: 5,
                  child: MainContent(),
                ),
              ],
            )
          : Column(
              children: [
                NavigationPanel(),
                MainContent(),
              ],
            ),
    );
  }
}

class NavigationPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListView(
        children: [
          ListTile(
            title: Text('Trips'),
            onTap: () {
              // Navigate to trips (if functionality is added later)
            },
          ),
          ListTile(
            title: Text('Vytvorit Tee Time'),
            onTap: () {
              // Push the CreateTeeTimeScreen directly
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTeeTimeScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Upravit Tee Time'),
            onTap: () {
              // Push the CreateTeeTimeScreen directly
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTeeTimeScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Vymazat Tee Time'),
            onTap: () {
              // Push the CreateTeeTimeScreen directly
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeleteTeeTimeScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(' '),
    );
  }
}
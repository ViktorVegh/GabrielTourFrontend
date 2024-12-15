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
      child: ListView.separated(
        itemBuilder: (context, index) {
          // Define the tiles with explicit types
          final List<Map<String, dynamic>> tiles = [
            {'title': 'Trips', 'screen': null},
            {'title': 'Vytvorit Tee Time', 'screen': CreateTeeTimeScreen()},
            {'title': 'Upravit Tee Time', 'screen': EditTeeTimeScreen()},
            {'title': 'Vymazat Tee Time', 'screen': DeleteTeeTimeScreen()},
          ];

          return ListTile(
            title: Text(
              tiles[index]['title'] as String, // Cast 'title' to String
              style: TextStyle(
                fontWeight: FontWeight.bold, // Make the text bold
                fontSize: 16,
              ),
            ),
            onTap: () {
              final screen = tiles[index]['screen'];
              if (screen != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => screen as Widget, // Cast 'screen' to Widget
                  ),
                );
              }
            },
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey, // Add a border between tiles
          thickness: 1, // Thickness of the border
        ),
        itemCount: 4,
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Calculate screen height
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.1), // Spacer above the logo
          Image.asset(
            'assets/icons/gabrieltour-logo-2023.png',
            height: screenHeight * 0.1, // Adjust the height of the logo
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/widgets/role_specific_navbar.dart';
import 'package:gabriel_tour_app/screens/user/tee_times.dart'; // Import TeeTimesScreen

class MyTripScreen extends StatelessWidget {
  const MyTripScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoleSpecificNavbar(
      role: 'user',
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Môj zájazd'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TeeTimesScreen(), // No need to pass teeTimes here
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        'assets/icons/tee_time.jpeg',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(
                          'Tee Times',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Text(
                'Toto je obrazovka s výletmi pre zákazníka',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

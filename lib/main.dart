import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/screens/auth.dart';
import 'package:gabriel_tour_app/screens/user/my_trip_screen.dart';
import 'package:gabriel_tour_app/screens/tour_guide/trips_screen.dart';
import 'package:gabriel_tour_app/screens/driver/calendar_screen.dart';
import 'package:gabriel_tour_app/services/drive_service.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';
import 'package:gabriel_tour_app/services/order_service.dart'; // Import OrderService

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final jwtService = JwtService();
    final driveService = DriveService(jwtService);

    return MaterialApp(
      title: 'Gabriel Tour App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthScreen(), // Default auth screen
        '/userTrips': (context) => MyTripScreen(
            orderService: OrderService(jwtService)), // Pass OrderService
        '/tourGuideTrips': (context) => TripsScreen(), // Screen for tour guides
        '/driverCalendar': (context) =>
            CalendarScreen(driveService: driveService)
      },
    );
  }
}

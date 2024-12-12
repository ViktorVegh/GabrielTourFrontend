import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/screens/auth.dart';
import 'package:gabriel_tour_app/screens/office/tee_time_create.dart';
import 'package:gabriel_tour_app/screens/office/OfficeWebDashboard.dart';
import 'package:gabriel_tour_app/screens/user/my_trip_screen.dart';
import 'package:gabriel_tour_app/screens/tour_guide/trips_screen.dart';
import 'package:gabriel_tour_app/screens/driver/calendar_screen.dart';
import 'package:gabriel_tour_app/services/auth_service.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';
import 'package:gabriel_tour_app/services/drive_service.dart';
import 'package:gabriel_tour_app/services/order_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService authService = AuthService();
  final JwtService jwtService = JwtService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final driveService = DriveService(jwtService);

    return MaterialApp(
      title: 'Gabriel Tour App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
     routes: {
  '/': (context) => AuthScreen(
        authService: authService,
        jwtService: jwtService,
      ),
  '/officeDashboard': (context) => OfficeWebDashboard(), // Office dashboard
  '/office': (context) => CreateTeeTimeScreen(), // Create Tee Time screen
  '/userTrips': (context) => MyTripScreen(orderService: OrderService(jwtService)),
  '/tourGuideTrips': (context) => TripsScreen(),
  '/driverCalendar': (context) => CalendarScreen(driveService: DriveService(jwtService)),
},
    );
  }
}

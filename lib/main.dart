import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/screens/auth.dart';

import 'package:gabriel_tour_app/screens/office/office_web_dashboard.dart';
import 'package:gabriel_tour_app/screens/user/my_trip_screen.dart';
import 'package:gabriel_tour_app/screens/tour_guide/trips_screen.dart';
import 'package:gabriel_tour_app/screens/driver/calendar_screen.dart';
import 'package:gabriel_tour_app/services/auth_service.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';
import 'package:gabriel_tour_app/services/drive_service.dart';
import 'package:gabriel_tour_app/services/order_service.dart';
import 'dart:io';
import 'dart:convert';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
void main() {
  HttpOverrides.global = MyHttpOverrides();
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
    '/userTrips': (context) => MyTripScreen(orderService: OrderService(jwtService)),
    '/tourGuideTrips': (context) => TripsScreen(),
    '/driverCalendar': (context) => CalendarScreen(driveService: DriveService(jwtService)),
},
    );
  }
}

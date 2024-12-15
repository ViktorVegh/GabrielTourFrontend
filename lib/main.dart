// import 'package:flutter/material.dart';
// import 'package:gabriel_tour_app/screens/auth.dart';
// import 'package:gabriel_tour_app/screens/user/my_trip_screen.dart';
// import 'package:gabriel_tour_app/screens/tour_guide/trips_screen.dart';
// import 'package:gabriel_tour_app/screens/driver/calendar_screen.dart';
// import 'package:gabriel_tour_app/services/auth_service.dart';
// import 'package:gabriel_tour_app/services/jwt_service.dart';
// import 'package:gabriel_tour_app/services/drives_schedule_service.dart';
// import 'package:gabriel_tour_app/services/order_service.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final AuthService authService = AuthService();
//   final JwtService jwtService = JwtService();

//   MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final driveService = DriveService(jwtService);

//     return MaterialApp(
//       title: 'Gabriel Tour App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => AuthScreen(
//               authService: authService,
//               jwtService: jwtService,
//             ),
//         '/userTrips': (context) => MyTripScreen(
//               orderService: OrderService(jwtService),
//             ),
//         '/tourGuideTrips': (context) => TripsScreen(),
//         '/driverCalendar': (context) => CalendarScreen(
//               driveService: driveService,
//             ),
//       },
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/screens/auth.dart';

import 'package:gabriel_tour_app/screens/office/office_web_dashboard.dart';
import 'package:gabriel_tour_app/screens/user/my_trip_screen.dart';
import 'package:gabriel_tour_app/screens/tour_guide/trips_screen.dart';
import 'package:gabriel_tour_app/screens/driver/calendar_screen.dart';
import 'package:gabriel_tour_app/screens/driver_manager/manage_calendar_screen.dart';
import 'package:gabriel_tour_app/services/auth_service.dart';
import 'package:gabriel_tour_app/services/drive_service.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';
import 'package:gabriel_tour_app/services/drives_schedule_service.dart';
import 'package:gabriel_tour_app/services/order_service.dart';
import 'package:gabriel_tour_app/services/person_service.dart';

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
    // Create services using the `jwtService`
    final drivesScheduleService = DrivesScheduleService(jwtService);
    final driveService = DriveService(jwtService);
    final personService = PersonService(jwtService);
    final orderService = OrderService(jwtService);

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
        '/userTrips': (context) => MyTripScreen(
              orderService: orderService,
            ),
        '/officeDashboard': (context) => OfficeWebDashboard(),
        '/tourGuideTrips': (context) => TripsScreen(),
        '/driverCalendar': (context) => CalendarScreen(
              drivesScheduleService: drivesScheduleService,
              personService: personService,
              jwtService: jwtService,
            ),
        '/manageCalendar': (context) => ManageCalendarScreen(
              driveService: driveService,
              drivesScheduleService: drivesScheduleService,
              personService: personService,
              jwtService: jwtService,
            ),
      },
    );
  }
}

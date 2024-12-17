import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/dtos/drive_dto.dart';
import 'package:gabriel_tour_app/dtos/drives_calendar_dto.dart';
import 'package:gabriel_tour_app/services/drive_service.dart';
import 'package:gabriel_tour_app/services/drives_schedule_service.dart';
import 'package:gabriel_tour_app/services/person_service.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';
import 'package:gabriel_tour_app/widgets/calendar_widget.dart';
import 'package:gabriel_tour_app/widgets/upcoming_drive_widget.dart';
import 'manage_drive_screen.dart';

class ManageCalendarScreen extends StatefulWidget {
  final DriveService driveService;
  final DrivesScheduleService drivesScheduleService;
  final PersonService personService;
  final JwtService jwtService;

  ManageCalendarScreen({
    required this.driveService,
    required this.drivesScheduleService,
    required this.personService,
    required this.jwtService,
  });

  @override
  _ManageCalendarScreenState createState() => _ManageCalendarScreenState();
}

class _ManageCalendarScreenState extends State<ManageCalendarScreen> {
  late Future<DrivesCalendarDTO> calendarData;
  late Future<List<DriveDTO>> upcomingDrives;
  String? userRole;

  @override
  void initState() {
    super.initState();
    calendarData = widget.drivesScheduleService.getMonthlyCalendar();
    upcomingDrives = widget.driveService.getAllUntrackedDrives();
    _fetchUserRole(); // Fetch user role using JwtService
  }

  Future<void> _fetchUserRole() async {
    try {
      final token = await widget.jwtService.getToken();
      if (token != null) {
        final role = widget.jwtService.getRoleFromToken(token);
        setState(() {
          userRole = role; // Update the user role
        });
      } else {
        setState(() {
          userRole = "unknown"; // Default role if token is null
        });
        print("Token is null. Unable to determine user role.");
      }
    } catch (e) {
      print("Error fetching user role: $e");
      setState(() {
        userRole = "unknown"; // Default role if unable to fetch
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Manage Drives Calendar',
          style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.05),
        ),
      ),
      body: userRole == null
          ? Center(
              child:
                  CircularProgressIndicator()) // Loader until role is fetched
          : FutureBuilder<DrivesCalendarDTO>(
              future: calendarData,
              builder: (context, calendarSnapshot) {
                if (calendarSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (calendarSnapshot.hasError) {
                  return Center(
                      child: Text('Error: ${calendarSnapshot.error}'));
                } else if (!calendarSnapshot.hasData) {
                  return Center(child: Text('No calendar data available.'));
                } else {
                  return Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CalendarWidget(
                          onDateSelected: (date) {},
                          monthStartDate: DateTime.parse(
                              calendarSnapshot.data!.monthStartDate),
                          monthEndDate: DateTime.parse(
                              calendarSnapshot.data!.monthEndDate),
                          drives:
                              _createEventMap(calendarSnapshot.data!.drives),
                          userRole: userRole!,
                          driveService: widget.driveService,
                          personService: widget.personService,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: FutureBuilder<List<DriveDTO>>(
                          future: upcomingDrives,
                          builder: (context, upcomingSnapshot) {
                            if (upcomingSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (upcomingSnapshot.hasError) {
                              return Center(
                                  child:
                                      Text('Error: ${upcomingSnapshot.error}'));
                            } else if (!upcomingSnapshot.hasData ||
                                upcomingSnapshot.data!.isEmpty) {
                              return Center(
                                child: Text(
                                  'No upcoming drives available.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Upcoming Drives',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: upcomingSnapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        final drive =
                                            upcomingSnapshot.data![index];
                                        return UpcomingDriveItem(
                                          drive: drive,
                                          personService: widget.personService,
                                          onManage: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ManageDriveScreen(
                                                  drive: drive,
                                                  driveService:
                                                      widget.driveService,
                                                  personService:
                                                      widget.personService,
                                                  userRole:
                                                      userRole!, // Pass userRole here
                                                ),
                                              ),
                                            ).then((_) {
                                              // Refresh upcomingDrives after returning
                                              setState(() {
                                                upcomingDrives = widget
                                                    .driveService
                                                    .getAllUntrackedDrives();
                                              });
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
    );
  }

  Map<DateTime, List<DriveDTO>> _createEventMap(List<DriveDTO> drives) {
    final Map<DateTime, List<DriveDTO>> eventMap = {};
    for (var drive in drives) {
      final date = DateTime.parse(drive.date);
      final key = DateTime(date.year, date.month, date.day);
      if (!eventMap.containsKey(key)) {
        eventMap[key] = [];
      }
      eventMap[key]!.add(drive);
    }
    debugPrint('Created event map for the calendar: $eventMap');
    return eventMap;
  }
}

import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/dtos/drives_calendar_dto.dart';
import 'package:gabriel_tour_app/dtos/drive_dto.dart';
import 'package:gabriel_tour_app/services/drives_schedule_service.dart';
import 'package:gabriel_tour_app/services/person_service.dart';
import 'package:gabriel_tour_app/widgets/calendar_widget.dart';
import 'package:gabriel_tour_app/widgets/drive_details_widget.dart';
import 'package:gabriel_tour_app/widgets/drive_item_widget.dart'; // Import DriveItem
import 'package:intl/intl.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';

class CalendarScreen extends StatefulWidget {
  final DrivesScheduleService drivesScheduleService;
  final PersonService personService;
  final JwtService jwtService;

  CalendarScreen({
    required this.drivesScheduleService,
    required this.personService,
    required this.jwtService,
  });

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Future<DrivesCalendarDTO> calendarData;
  DateTime? selectedDate;
  DateTime visibleMonth = DateTime.now();
  String? userRole; // Tracks the currently visible month

  @override
  void initState() {
    super.initState();
    calendarData = widget.drivesScheduleService.getMonthlyCalendar();
    debugPrint('Initialized CalendarScreen with future data fetching.');
    _fetchUserRole();
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
        debugPrint("Token is null. Unable to determine user role.");
      }
    } catch (e) {
      debugPrint("Error fetching user role: $e");
      setState(() {
        userRole = "unknown"; // Default role if unable to fetch
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1, // Slight elevation
        title: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.02),
          child: Image.asset(
            'assets/icons/gabrieltour-logo-2023.png', // Logo
            height: screenHeight * 0.04, // Relative height
          ),
        ),
        centerTitle: true, // Center the logo
      ),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Screen Title Container
          SizedBox(height: screenHeight * 0.015), // Relative spacing
          Container(
            width: double.infinity,
            color: const Color.fromARGB(201, 146, 96, 52), // Brown background
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
            child: Text(
              'Drives Calendar', // Screen Title
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.021, // Relative font size
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: userRole == null
                ? Center(
                    child: Text(
                      'User role is not available.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : FutureBuilder<DrivesCalendarDTO>(
                    future: calendarData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        debugPrint('Fetching calendar data...');
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        debugPrint(
                            'Error fetching calendar data: ${snapshot.error}');
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                        );
                      } else if (!snapshot.hasData) {
                        debugPrint('No calendar data available.');
                        return Center(
                          child: Text(
                            'No data available.',
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                        );
                      } else {
                        final calendar = snapshot.data!;
                        final drivesByDate =
                            _groupDrivesByDate(calendar.drives);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 4,
                              child: CalendarWidget(
                                onDateSelected: (date) {
                                  debugPrint('Date selected: $date');
                                  setState(() {
                                    selectedDate = date;
                                    visibleMonth =
                                        DateTime(date.year, date.month);
                                  });
                                },
                                monthStartDate:
                                    DateTime.parse(calendar.monthStartDate),
                                monthEndDate:
                                    DateTime.parse(calendar.monthEndDate),
                                drives: _createEventMap(calendar.drives),
                                userRole: userRole!,
                                driveService: null,
                                personService: widget.personService,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: screenWidth * 0.02),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: drivesByDate.keys.length,
                                      itemBuilder: (context, index) {
                                        final date =
                                            drivesByDate.keys.elementAt(index);
                                        final drives = drivesByDate[date]!;

                                        if (date.month != visibleMonth.month) {
                                          return SizedBox.shrink();
                                        }

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '${DateFormat.EEEE().format(date)}, ${date.day} ${DateFormat.MMMM().format(date)}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            ...drives.map((drive) {
                                              return DriveItem(
                                                drive: drive,
                                                onTap: () {
                                                  debugPrint(
                                                      'Drive tapped: $drive');
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DriveDetailsWidget(
                                                        drive: drive,
                                                        personService: widget
                                                            .personService,
                                                        onClose: () {
                                                          debugPrint(
                                                              'DriveDetailsWidget closed.');
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            }).toList(),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Group drives by their date
  Map<DateTime, List<DriveDTO>> _groupDrivesByDate(List<DriveDTO> drives) {
    final Map<DateTime, List<DriveDTO>> grouped = {};
    for (var drive in drives) {
      final date = DateTime.parse(drive.date);
      final key = DateTime(date.year, date.month, date.day);
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(drive);
    }
    debugPrint('Grouped drives by date: $grouped');
    return grouped;
  }

  // Create event map for the calendar
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

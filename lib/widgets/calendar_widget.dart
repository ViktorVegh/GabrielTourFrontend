import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/dtos/drive_dto.dart';
import 'package:gabriel_tour_app/widgets/drive_item_widget.dart';
import 'package:gabriel_tour_app/services/drive_service.dart';
import 'package:gabriel_tour_app/services/person_service.dart';
import 'package:gabriel_tour_app/widgets/drive_details_widget.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime monthStartDate;
  final DateTime monthEndDate;
  final Map<DateTime, List<DriveDTO>> drives;
  final String userRole;
  final DriveService? driveService; // Optional
  final PersonService? personService; // Optional

  CalendarWidget({
    required this.onDateSelected,
    required this.monthStartDate,
    required this.monthEndDate,
    required this.drives,
    required this.userRole, // Always required
    this.driveService,
    this.personService,
  });

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late List<DateTime> _visibleMonths;

  @override
  void initState() {
    super.initState();
    _visibleMonths = _generateVisibleMonths(
      startDate: widget.monthStartDate,
      endDate: widget.monthEndDate,
    );
  }

  List<DateTime> _generateVisibleMonths({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    List<DateTime> months = [];
    DateTime current = DateTime(startDate.year, startDate.month);
    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      months.add(current);
      current = DateTime(current.year, current.month + 1);
    }
    return months;
  }

  List<DateTime> _getDaysForMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);

    int startOffset = firstDay.weekday % 7;
    int endOffset = 7 - ((lastDay.day + startOffset) % 7);
    endOffset = endOffset == 7 ? 0 : endOffset;

    final startDate = firstDay.subtract(Duration(days: startOffset));
    final endDate = lastDay.add(Duration(days: endOffset));

    return List.generate(
      endDate.difference(startDate).inDays + 1,
      (index) => startDate.add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                  .map((day) => Text(
                        day,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ))
                  .toList(),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _visibleMonths.length,
            itemBuilder: (context, index) {
              final month = _visibleMonths[index];
              final days = _getDaysForMonth(month);

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "${_monthName(month.month)} ${month.year}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      final day = days[index];
                      final isCurrentMonth = day.month == month.month;
                      final hasDrives = widget.drives.containsKey(day);

                      return GestureDetector(
                        onTap: () {
                          if (isCurrentMonth) {
                            widget.onDateSelected(day);

                            if (widget.userRole == 'driver') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DrivesDetailsPage(
                                    selectedDay: day,
                                    drives: widget.drives[day] ?? [],
                                    userRole: widget
                                        .userRole, // Pass the role to the details page
                                    driveService: widget
                                        .driveService, // Pass the service for editing
                                    personService: widget
                                        .personService, // Pass person service
                                  ),
                                ),
                              );
                            } else if (widget.userRole == 'drivermanager' ||
                                widget.userRole == 'office') {
                              if (widget.driveService == null ||
                                  widget.personService == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Services are missing for manager role'),
                                  ),
                                );
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DrivesDetailsPage(
                                    selectedDay: day,
                                    drives: widget.drives[day] ?? [],
                                    userRole: widget.userRole,
                                    driveService: widget.driveService,
                                    personService: widget.personService,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Unauthorized role')),
                              );
                            }
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          decoration: BoxDecoration(
                            color: hasDrives
                                ? Colors.brown
                                : Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${day.day}',
                            style: TextStyle(
                              color: hasDrives
                                  ? Colors.white
                                  : isCurrentMonth
                                      ? Colors.black
                                      : Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}

class DrivesDetailsPage extends StatelessWidget {
  final DateTime selectedDay;
  final List<DriveDTO> drives;
  final String userRole;
  final DriveService? driveService; // Nullable
  final PersonService? personService; // Nullable

  DrivesDetailsPage({
    required this.selectedDay,
    required this.drives,
    required this.userRole,
    this.driveService, // Optional
    this.personService, // Optional
  });
  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.02),
          child: Image.asset(
            'assets/icons/gabrieltour-logo-2023.png',
            height: screenHeight * 0.04,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.015),

          Container(
            width: double.infinity,
            color: const Color.fromARGB(201, 146, 96, 52),
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
            child: Text(
              '${_formattedDate(selectedDay)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.021,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Body Section: Drives List
          Expanded(
            child: drives.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        userRole == 'office' || userRole == 'drivermanager'
                            ? 'Žiadne jazdy pre vybraný deň.' // Slovak for office or manager
                            : 'No drives scheduled for this day.', // Default for other roles
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: drives.length,
                    itemBuilder: (context, index) {
                      final drive = drives[index];
                      return DriveItem(
                        drive: drive,
                        onTap: () {
                          debugPrint('Drive tapped: $drive');
                          if (userRole == 'driver') {
                            // Open DriveDetailsWidget for drivers
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DriveDetailsWidget(
                                  drive: drive,
                                  personService: personService!,
                                  onClose: () => Navigator.pop(context),
                                ),
                              ),
                            );
                          } else if (userRole == 'drivermanager' ||
                              userRole == 'office') {
                            // edit/delete options for managers or office staff
                            _showEditDeleteOptions(context, drive);
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showEditDeleteOptions(BuildContext context, DriveDTO drive) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: Colors.blue),
              title: Text('Edit Drive'),
              onTap: () {
                Navigator.pop(context);
                _editDrive(context, drive);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Delete Drive'),
              onTap: () {
                Navigator.pop(context);
                _deleteDrive(context, drive);
              },
            ),
          ],
        );
      },
    );
  }

  void _editDrive(BuildContext context, DriveDTO drive) {
    if (driveService == null) {
      debugPrint('DriveService is not available');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('DriveService is not configured')),
      );
      return;
    }

    debugPrint('Edit drive: $drive');
  }

  void _deleteDrive(BuildContext context, DriveDTO drive) async {
    if (driveService == null) {
      debugPrint('DriveService is not available');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('DriveService is not configured')),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Drive'),
        content: Text('Are you sure you want to delete this drive?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      debugPrint('Deleting drive: $drive');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Drive deleted successfully')),
      );
    }
  }

  String _formattedDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }
}

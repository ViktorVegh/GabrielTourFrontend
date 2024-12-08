import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/dtos/drive_dto.dart';
import 'package:gabriel_tour_app/services/drive_service.dart';

class CalendarScreen extends StatefulWidget {
  final DriveService driveService;

  CalendarScreen({required this.driveService});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Future<List<DriveDTO>> drives;

  @override
  void initState() {
    super.initState();
    drives = widget.driveService.getDrivesForCurrentWeek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weekly Schedule')),
      body: FutureBuilder<List<DriveDTO>>(
        future: drives,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No drives available.'));
          } else {
            final driveList = snapshot.data!;
            return ListView.builder(
              itemCount: driveList.length,
              itemBuilder: (context, index) {
                final drive = driveList[index];
                return ListTile(
                  title:
                      Text('${drive.departurePlace} → ${drive.arrivalPlace}'),
                  subtitle: Text('${drive.date} - ${drive.pickupTime}'),
                  onTap: () {
                    // Navigate to edit screen
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

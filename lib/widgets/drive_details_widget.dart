import 'package:flutter/material.dart';
import 'package:gabriel_tour_app/dtos/drive_dto.dart';
import 'package:gabriel_tour_app/services/person_service.dart';

class DriveDetailsWidget extends StatelessWidget {
  final DriveDTO drive;
  final PersonService personService;
  final VoidCallback onClose;

  DriveDetailsWidget({
    required this.drive,
    required this.personService,
    required this.onClose,
  });

  Future<String> _fetchUserEmail(int userId) async {
    try {
      final person = await personService.getPersonByProfisId(userId);
      return person?.email ?? 'Unknown User';
    } catch (e) {
      return 'Error User';
    }
  }

  Future<String> _fetchDriverEmail(int driverId) async {
    try {
      final person = await personService.getPersonById(driverId, 'driver');
      return person?.email ?? 'Unknown Driver';
    } catch (e) {
      return 'Error Driver';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userIds = drive.userIds ?? [];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Drive Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: onClose,
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: Future.wait(userIds.map((id) => _fetchUserEmail(id))),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading user details',
                style:
                    TextStyle(color: Colors.red, fontSize: screenWidth * 0.05),
              ),
            );
          }

          final userEmails = snapshot.data ?? [];

          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(screenWidth * 0.05),
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Header
                  Center(
                    child: Text(
                      'Date: ${drive.date}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Departure Section
                  _buildDetailSection(
                    title: 'Departure',
                    time: drive.pickupTime != null
                        ? _formatTime(drive.pickupTime!)
                        : 'N/A',
                    place: drive.departurePlace,
                    screenWidth: screenWidth,
                  ),

                  // Arrival Section
                  _buildDetailSection(
                    title: 'Arrival',
                    time: drive.dropoffTime != null
                        ? _formatTime(drive.dropoffTime!)
                        : 'N/A',
                    place: drive.arrivalPlace,
                    screenWidth: screenWidth,
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Reason
                  _buildSectionHeader(
                    'Reason',
                    drive.customReason ?? 'Not provided',
                    screenWidth,
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Driver Email
                  FutureBuilder<String>(
                    future: drive.driverId != null
                        ? _fetchDriverEmail(drive.driverId!)
                        : Future.value('No Driver Assigned'),
                    builder: (context, driverSnapshot) {
                      if (driverSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (driverSnapshot.hasError) {
                        return _buildSectionHeader('Driver',
                            'Error loading driver details', screenWidth);
                      }

                      return _buildSectionHeader(
                        'Driver',
                        driverSnapshot.data ?? 'Unknown Driver',
                        screenWidth,
                      );
                    },
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Users Section
                  Text(
                    'Users:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                  ...userEmails.map(
                    (email) => Text(
                      email,
                      style: TextStyle(fontSize: screenWidth * 0.045),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailSection({
    required String title,
    required String time,
    required String place,
    bool arrow = false,
    required double screenWidth,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        Row(
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            if (arrow)
              Icon(
                Icons.arrow_forward,
                size: screenWidth * 0.05,
                color: Colors.grey.shade600,
              ),
            SizedBox(width: screenWidth * 0.02),
            Text(
              place,
              style: TextStyle(fontSize: screenWidth * 0.045),
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.03),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String value, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: screenWidth * 0.045),
        ),
      ],
    );
  }

  String _formatTime(String dateTime) {
    final date = DateTime.parse(dateTime);
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
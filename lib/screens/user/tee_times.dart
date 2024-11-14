import 'package:flutter/material.dart';
import '../../dtos/tee_time_dto.dart'; // Use TeeTimeDTO instead of TeeTime
import '../../widgets/tee_time_widget.dart'; // Import TeeTimeWidget component
import 'package:gabriel_tour_app/widgets/role_specific_navbar.dart'; // Import RoleSpecificNavbar
import 'package:gabriel_tour_app/services/tee_time_service.dart'; // Import TeeTimeService
import 'package:gabriel_tour_app/services/jwt_service.dart'; // Import JwtService

class TeeTimesScreen extends StatefulWidget {
  const TeeTimesScreen({Key? key}) : super(key: key);

  @override
  _TeeTimesScreenState createState() => _TeeTimesScreenState();
}

class _TeeTimesScreenState extends State<TeeTimesScreen> {
  final TeeTimeService _teeTimeService = TeeTimeService(JwtService());
  List<TeeTimeDTO> _teeTimes = []; // Use TeeTimeDTO
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTeeTimesForUser();
  }

  Future<void> _fetchTeeTimesForUser() async {
    setState(() {
      _isLoading = true;
    });

    int userId = 1; // Replace with actual user ID from context/session
    final fetchedTeeTimes = await _teeTimeService.getTeeTimesByUserId(userId);

    setState(() {
      _teeTimes = fetchedTeeTimes ?? []; // Set fetched TeeTimeDTO list directly
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RoleSpecificNavbar(
      role: 'user',
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tee Times'),
          backgroundColor: Colors.orange,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _teeTimes.isEmpty
                ? Center(child: Text("No Tee Times available for this user"))
                : ListView.builder(
                    itemCount: _teeTimes.length,
                    itemBuilder: (context, index) {
                      final TeeTimeDTO teeTime = _teeTimes[index];
                      const String placeholderGolfCourseName =
                          'Golf Course Name';

                      return TeeTimeWidget(
                        teeTime: teeTime, // Use TeeTimeDTO directly
                        golfCourseName: placeholderGolfCourseName,
                      );
                    },
                  ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../dtos/tee_time_dto.dart';
import '../../widgets/tee_time_widget.dart';
import 'package:gabriel_tour_app/widgets/role_specific_navbar.dart';
import 'package:gabriel_tour_app/services/tee_time_service.dart';
import 'package:gabriel_tour_app/services/jwt_service.dart';

class TeeTimesScreen extends StatefulWidget {
  const TeeTimesScreen({Key? key}) : super(key: key);

  @override
  _TeeTimesScreenState createState() => _TeeTimesScreenState();
}

class _TeeTimesScreenState extends State<TeeTimesScreen> {
  final JwtService _authService = JwtService();
  final TeeTimeService _teeTimeService = TeeTimeService(JwtService());
  List<TeeTimeDTO> _teeTimes = [];
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

    try {
      int? userId = await _authService
          .getUserIdFromToken(); // Retrieve userId from AuthService
      if (userId == null) {
        throw Exception("Failed to retrieve user ID.");
      }

      final fetchedTeeTimes = await _teeTimeService.getTeeTimesByUserId(userId);

      setState(() {
        _teeTimes = fetchedTeeTimes ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
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
                        teeTime: teeTime,
                        golfCourseName: placeholderGolfCourseName,
                      );
                    },
                  ),
      ),
    );
  }
}

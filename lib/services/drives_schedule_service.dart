import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/drives_calendar_dto.dart';
import 'jwt_service.dart';

class DrivesScheduleService {
  final JwtService _jwtService;

  DrivesScheduleService(this._jwtService);

  Future<DrivesCalendarDTO> getMonthlyCalendar() async {
    final token = await _jwtService.getToken();
    final response = await http.get(
      Uri.parse('http://localhost:9090/api/drives-calendar/monthly'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return DrivesCalendarDTO.fromJson(body);
    } else if (response.statusCode == 403) {
      throw Exception('Access denied. Ensure the user has the correct roles.');
    } else {
      throw Exception('Failed to load monthly calendar drives');
    }
  }

  Future<void> removeDrivesFromCalendar(List<int> driveIds) async {
    final token = await _jwtService.getToken();
    final response = await http.delete(
      Uri.parse('http://localhost:9090/api/drives/remove'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(driveIds),
    );

    if (response.statusCode == 204) {
      print('Drives removed from the calendar successfully.');
    } else if (response.statusCode == 403) {
      throw Exception('Access denied. Ensure the user has the correct roles.');
    } else {
      throw Exception('Failed to remove drives from the calendar.');
    }
  }

  Future<void> addDriveToCalendar(int driveId) async {
    final token = await _jwtService.getToken();
    final response = await http.post(
      Uri.parse('http://localhost:9090/api/drives/add?driveId=$driveId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 204) {
      print('Drive added to the calendar successfully.');
    } else if (response.statusCode == 403) {
      throw Exception('Access denied. Ensure the user has the correct roles.');
    } else {
      throw Exception('Failed to add drive to the calendar.');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/drive_dto.dart';
import 'jwt_service.dart';

class DriveService {
  final JwtService _jwtService;

  DriveService(this._jwtService);

  Future<List<DriveDTO>> getDrivesForCurrentWeek() async {
    final token = await _jwtService.getToken();
    final response = await http.get(
      Uri.parse('http://localhost:9090/api/drives/current-week'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => DriveDTO.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load drives for the current week');
    }
  }

  Future<DriveDTO> editDrive({
    required int driveId,
    required DateTime pickupTime,
    required DateTime dropoffTime,
    required int driverId,
  }) async {
    final token = await _jwtService.getToken();
    final response = await http.put(
      Uri.parse('http://localhost:9090/api/drives/$driveId/edit'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'pickupTime': pickupTime.toIso8601String(),
        'dropoffTime': dropoffTime.toIso8601String(),
        'driver': driverId,
      }),
    );

    if (response.statusCode == 200) {
      return DriveDTO.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to edit drive');
    }
  }
}

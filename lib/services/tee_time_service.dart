import 'dart:convert';
import 'package:gabriel_tour_app/dtos/tee_time_request_dto.dart';
import 'package:http/http.dart' as http;
import 'package:gabriel_tour_app/dtos/tee_time_dto.dart';
import 'jwt_service.dart';

class TeeTimeService {
  final String baseUrl = 'http://localhost:9090/api/teetimes';
  final JwtService _jwtService;

  TeeTimeService(this._jwtService);

  // Get tee times by user ID
  Future<List<TeeTimeDTO>?> getTeeTimesByUserId(int userId) async {
    final token = await _jwtService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/user/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((teeTime) => TeeTimeDTO.fromJson(teeTime))
          .toList();
    } else {
      // Handle error
      return null;
    }
  }

  // Create a new tee time
  Future<TeeTimeDTO?> createTeeTime(TeeTimeRequestDTO teeTimeRequest) async {
    final token = await _jwtService.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(teeTimeRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return TeeTimeDTO.fromJson(json.decode(response.body));
    } else {
      // Handle error
      return null;
    }
  }
}

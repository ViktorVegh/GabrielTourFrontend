import 'dart:convert';
import 'package:http/http.dart' as http;
import 'jwt_service.dart';
import 'package:gabriel_tour_app/dtos/tee_time_dto.dart';
import 'package:gabriel_tour_app/dtos/tee_time_request_dto.dart';

class TeeTimeService {
  final String baseUrl = 'http://13.53.236.35:9090/api/teetimes';
  final JwtService _jwtService;

  TeeTimeService(this._jwtService);

  Future<List<TeeTimeDTO>?> getTeeTimesForUser() async {
    try {
      final userId = await _jwtService.getUserIdFromToken();
      if (userId == null) {
        print('Error: User ID not found in token.');
        return null;
      }

      final token = await _jwtService.getToken();
      if (token == null) {
        print('Error: Token not found.');
        return null;
      }

      final url = '$baseUrl/user/$userId';
      print('Making GET request to: $url');
      print('Authorization: Bearer $token');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List jsonResponse = json.decode(response.body);
        return jsonResponse.map((e) => TeeTimeDTO.fromJson(e)).toList();
      } else {
        print(
            'Error: Failed to fetch tee times. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching tee times: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<TeeTimeDTO?> createTeeTime(TeeTimeRequestDTO teeTimeRequest) async {
    try {
      final token = await _jwtService.getToken();
      if (token == null) {
        print('Error: Token not found.');
        return null;
      }

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
        print(
            'Error: Failed to create tee time. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error creating tee time: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
  Future<List<TeeTimeDTO>?> getTeeTimesForSpecificUser(int id) async {
    try {
      if (id == null) {
        print('Error: User ID not found in token.');
        return null;
      }

      final token = await _jwtService.getToken();
      if (token == null) {
        print('Error: Token not found.');
        return null;
      }

      final url = '$baseUrl/user/$id';
      print('Making GET request to: $url');
      print('Authorization: Bearer $token');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List jsonResponse = json.decode(response.body);
        return jsonResponse.map((e) => TeeTimeDTO.fromJson(e)).toList();
      } else {
        print(
            'Error: Failed to fetch tee times. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching tee times: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
}

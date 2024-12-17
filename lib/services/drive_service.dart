import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/drive_dto.dart';
import 'jwt_service.dart';

class DriveService {
  final JwtService _jwtService;

  DriveService(this._jwtService);

  // Fetch all untracked drives
  Future<List<DriveDTO>> getAllUntrackedDrives() async {
    final token = await _jwtService.getToken();
    final response = await http.get(
      Uri.parse('http://localhost:9090/api/drives/upcoming'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((item) => DriveDTO.fromJson(item)).toList();
    } else if (response.statusCode == 403) {
      throw Exception('Access denied. Ensure the user has the correct roles.');
    } else {
      throw Exception('Failed to load untracked drives');
    }
  }

  // Create a new drive
  Future<DriveDTO> createDrive(DriveDTO drive) async {
    final token = await _jwtService.getToken();
    final response = await http.post(
      Uri.parse('http://13.53.236.35:9090/api/drives'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(drive.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> body = json.decode(response.body);
      return DriveDTO.fromJson(body);
    } else if (response.statusCode == 403) {
      throw Exception('Access denied. Ensure the user has the correct roles.');
    } else {
      throw Exception('Failed to create a new drive');
    }
  }

  // Update an existing drive
  Future<DriveDTO> updateDrive(int driveId, DriveDTO drive) async {
    final token = await _jwtService.getToken();
    final response = await http.put(
      Uri.parse('http://localhost:9090/api/drives/$driveId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(drive.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      return DriveDTO.fromJson(body);
    } else if (response.statusCode == 403) {
      throw Exception('Access denied. Ensure the user has the correct roles.');
    } else {
      throw Exception('Failed to update the drive');
    }
  }

  // Delete a drive
  Future<void> deleteDrive(int driveId) async {
    final token = await _jwtService.getToken();
    final response = await http.delete(
      Uri.parse('http://localhost:9090/api/drives/$driveId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      if (response.statusCode == 403) {
        throw Exception(
            'Access denied. Ensure the user has the correct roles.');
      } else {
        throw Exception('Failed to delete the drive');
      }
    }
  }

  // Fetch all drives
  Future<List<DriveDTO>> getAllDrives() async {
    final token = await _jwtService.getToken();
    final response = await http.get(
      Uri.parse('http://13.53.236.35:9090/api/drives/all'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((item) => DriveDTO.fromJson(item)).toList();
    } else if (response.statusCode == 403) {
      throw Exception('Access denied. Ensure the user has the correct roles.');
    } else {
      throw Exception('Failed to fetch all drives');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gabriel_tour_app/dtos/login_request.dart';

class AuthService {
  final String baseUrl = 'http://13.53.236.35:9090';

  // // Register user
  // Future<String> register(RegisterRequest request) async {
  //   final url = Uri.parse('$baseUrl/auth/register');
  //   final headers = {'Content-Type': 'application/json'};
  //   final body = jsonEncode(request.toJson());

  //   final response = await http.post(url, headers: headers, body: body);

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = jsonDecode(response.body);
  //     return responseData['token'];
  //   } else {
  //     throw Exception('Failed to register: ${response.body}');
  //   }
  // }

  // Login user
  Future<String> login(LoginRequest request) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(request.toJson());

    print('DEBUG: Making POST request to $url');
    print('DEBUG: Headers: $headers');
    print('DEBUG: Body: $body');

    final response = await http.post(url, headers: headers, body: body);

    print('DEBUG: Response status code: ${response.statusCode}');
    print('DEBUG: Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData['token'];
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  // Logout
  Future<void> logout() async {
    print("Logged out successfully");
  }

  //  reset-password endpoint
  Future<String> resetPassword(String email) async {
    final url = Uri.parse('$baseUrl/auth/reset-password');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData['message'];
    } else {
      throw Exception('Failed to send reset link: ${response.body}');
    }
  }
}

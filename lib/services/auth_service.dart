import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gabriel_tour_app/dtos/login_request.dart';
import 'package:gabriel_tour_app/dtos/register_request.dart';

class AuthService {
  final String baseUrl =
      'http://localhost:9090'; // Adjust the base URL as needed

  // Register user
  Future<String> register(RegisterRequest request) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(request.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return the token or success message
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  // Login user
  Future<String> login(LoginRequest request) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(request.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return the token or success message
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  // Logout (this would just invalidate the token client-side)
  Future<void> logout() async {
    // Assuming the token is stored in local storage or elsewhere
    // You can clear the token or perform other client-side actions
    print("Logged out successfully");
  }
}

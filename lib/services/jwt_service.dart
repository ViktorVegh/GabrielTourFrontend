import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JwtService {
  // Save the JWT token to local storage
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  // Retrieve the JWT token from local storage
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  // Decode the JWT token and get the role
  String getRoleFromToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken['role'];
  }

  // Decode the JWT token and get the user ID from `sub`
  Future<int?> getUserIdFromToken() async {
    String? token = await getToken();
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return int.tryParse(decodedToken['sub']);
    }
    return null;
  }

  // Check if the token is expired
  bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  // Clear the token (for logging out)
  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}

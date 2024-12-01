import 'dart:convert';
import 'package:http/http.dart' as http;
import 'jwt_service.dart';
import 'package:gabriel_tour_app/dtos/order_dto.dart';

class OrderService {
  final String baseUrl = 'http://localhost:9090/order';
  final JwtService _jwtService;

  OrderService(this._jwtService);

  /// Fetches the order details for the user based on their token.
  Future<OrderDTO?> getOrderDetailsForUser() async {
    try {
      // Retrieve the user ID from the token
      final userId = await _jwtService.getUserIdFromToken();
      if (userId == null) {
        print('Error: User ID not found in token.');
        return null;
      }

      // Retrieve the JWT token for authorization
      final token = await _jwtService.getToken();
      if (token == null) {
        print('Error: Token not found.');
        return null;
      }

      // Log the request URL and headers for debugging
      final url = '$baseUrl/get-orderDetails?id=$userId';
      print('Making GET request to: $url');
      print('Authorization: Bearer $token');

      // Make the GET request with the correct `id` parameter
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Log the status code and response body
      print('Response status: ${response.statusCode}');

      // Decode the response explicitly using utf8.decode
      final decodedBody = utf8.decode(response.bodyBytes); // Fix for encoding
      print('Decoded Response Body: $decodedBody');

      // Parse the response JSON
      final jsonResponse = json.decode(decodedBody);

      // Log the parsed JSON to verify structure
      print('Parsed JSON Response: $jsonResponse');

      // Check if `orderDetail` exists and is not null
      if (jsonResponse['orderDetail'] == null) {
        print('Error: orderDetail is null or missing in response.');
        return null;
      }

      // Return the parsed OrderDTO object
      return OrderDTO.fromJson(jsonResponse);
    } catch (e, stackTrace) {
      print('Error fetching order details: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
}

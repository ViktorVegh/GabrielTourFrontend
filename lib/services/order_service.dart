import 'dart:convert';
import 'package:http/http.dart' as http;
import 'jwt_service.dart';
import 'package:gabriel_tour_app/dtos/order_dto.dart';

class OrderService {
  final String baseUrl = 'http://localhost:9090/order';
  final JwtService _jwtService;

  OrderService(this._jwtService);

  Future<OrderDTO?> getOrderDetailsForUser() async {
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

      final url = '$baseUrl/get-orderDetails?id=$userId';
      print('Making GET request to: $url');
      print('Authorization: Bearer $token');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');

      final decodedBody = utf8.decode(response.bodyBytes);
      print('Decoded Response Body: $decodedBody');

      final jsonResponse = json.decode(decodedBody);

      print('Parsed JSON Response: $jsonResponse');

      if (jsonResponse['orderDetail'] == null) {
        print('Error: orderDetail is null or missing in response.');
        return null;
      }

      return OrderDTO.fromJson(jsonResponse);
    } catch (e, stackTrace) {
      print('Error fetching order details: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
}

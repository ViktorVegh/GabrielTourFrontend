import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gabriel_tour_app/dtos/person_dto.dart';
import 'jwt_service.dart';

class PersonService {
  final JwtService _jwtService;

  PersonService(this._jwtService);

  Future<List<PersonDTO>> getAllPersons() async {
    // Changed List<Person> to List<PersonDTO>
    final token = await _jwtService.getToken();
    final response = await http.get(
      Uri.parse('http://localhost:9090/api/person/all'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body
          .map((dynamic item) => PersonDTO.fromJson(item))
          .toList(); // Ensure using PersonDTO
    } else {
      throw Exception('Failed to load persons');
    }
  }

  Future<PersonDTO?> searchPersonByEmail(String email) async {
    final token = await _jwtService.getToken();
    final response = await http.get(
      Uri.parse(
          'http://localhost:9090/api/person/search_by_email?email=$email'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return PersonDTO.fromJson(
          json.decode(response.body)); // Ensure using PersonDTO
    } else {
      return null;
    }
  }

  Future<PersonDTO?> getPersonById(int id, String role) async {
    final token = await _jwtService.getToken();
    final response = await http.get(
      Uri.parse('http://localhost:9090/api/person/$id/$role'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return PersonDTO.fromJson(
          json.decode(response.body)); // Ensure using PersonDTO
    } else {
      return null;
    }
  }
}

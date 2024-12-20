import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gabriel_tour_app/dtos/person_dto.dart';
import 'jwt_service.dart';

class PersonService {
  final JwtService _jwtService;

  PersonService(this._jwtService);

  Future<List<PersonDTO>> getAllPersons() async {
    final token = await _jwtService.getToken();
    final response = await http.get(
      Uri.parse('http://13.53.236.35:9090/api/person/all'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => PersonDTO.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load persons');
    }
  }

  Future<PersonDTO?> searchPersonByEmail(String email) async {
    final token = await _jwtService.getToken();
    final response = await http.get(
      Uri.parse(
          'http://13.53.236.35:9090/api/person/search_by_email?email=$email'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return PersonDTO.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<PersonDTO?> getPersonById(int id, String role) async {
    final token = await _jwtService.getToken();
    final response = await http.get(
      Uri.parse('http://13.53.236.35:9090/api/person/$id/$role'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return PersonDTO.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<PersonDTO?> getPersonByProfisId(int profisId) async {
    final token = await _jwtService.getToken();
    final response = await http.get(
      Uri.parse('http://13.53.236.35:9090/api/person/profis/$profisId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return PersonDTO.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to load person by profis ID');
    }
  }

  Future<List<PersonDTO>> getAllDrivers() async {
    final token = await _jwtService.getToken();
    final response = await http.get(
      Uri.parse('http://13.53.236.35:9090/api/person/all/drivers'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => PersonDTO.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load drivers');
    }
  }
}

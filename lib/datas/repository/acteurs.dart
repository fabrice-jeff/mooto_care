import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../src/api.dart';

class ActeurRepository {
  final String api;
  ActeurRepository({required this.api});

  //Register
  Future<Map<String, dynamic>?> register(data) async {
    final endpoint = Api.REGISTER;
    final url = Uri.parse(api + endpoint);
    final response = await http.post(
      url,
      body: data,
      headers: {},
    );
    Map<String, dynamic>? results;

    if (response.statusCode == 200) {
      results = jsonDecode(response.body);
      print(results);
    }
    return results;
  }

  //Login
  Future<Map<String, dynamic>?> login(data) async {
    final endpoint = Api.LOGIN;
    final url = Uri.parse(api + endpoint);
    final response = await http.post(
      url,
      body: data,
      headers: {},
    );
    late Map<String, dynamic> results;

    if (response.statusCode == 200) {
      results = jsonDecode(response.body);
    }
    return results;
  }
}

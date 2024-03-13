import 'dart:convert';

import 'package:http/http.dart' as http;
import '../api.dart';

class ActeurRepository {
  final String api;
  ActeurRepository({required this.api});

  //Register
  Future<Map<String, dynamic>?> register(data) async {
    final endpoint = Api.register;
    final url = Uri.parse(api + endpoint);
    final response = await http.post(
      url,
      body: data,
      headers: {},
    );
    Map<String, dynamic> results;
    print(response.body);
    try {
      results = jsonDecode(response.body);
      return results;
    } catch (e) {
      print(response.body);
      return null;
    }
  }

  //Login
  Future<Map<String, dynamic>> login(data) async {
    final endpoint = Api.login;
    final url = Uri.parse(api + endpoint);
    final response = await http.post(
      url,
      body: data,
      headers: {},
    );
    Map<String, dynamic> results;
    results = jsonDecode(response.body);

    return results;
  }

  //Verification de l'adresse email de l'utilisateur
  Future<Map<String, dynamic>?> verificationEmail(data) async {
    final endpoint = Api.verificationEmail;
    final url = Uri.parse(api + endpoint);
    final response = await http.post(
      url,
      body: data,
      headers: {},
    );
    Map<String, dynamic> results;
    try {
      results = jsonDecode(response.body);
      return results;
    } catch (e) {
      print('erreur');
      return null;
    }
  }

  // Renvoi de l'email de l'utilisateur
  Future<Map<String, dynamic>?> resendValidationMail(data) async {
    final endpoint = Api.resendValidationEmail;
    final url = Uri.parse(api + endpoint);
    final response = await http.post(
      url,
      body: data,
      headers: {},
    );
    Map<String, dynamic> results;
    try {
      results = jsonDecode(response.body);
      return results;
    } catch (e) {
      print('erreur');
      return null;
    }
  }
}

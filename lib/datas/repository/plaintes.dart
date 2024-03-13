import 'dart:convert';

import '../api.dart';
import 'package:http/http.dart' as http;

import '../../utils/share_preference.dart';
import '../models/acteur.dart';

class PlainteRepository {
  final String api;
  PlainteRepository({required this.api});
  Acteur? acteur = SharePreferences.getActeur();

  Future<Map<String, dynamic>?> addDemandeAttestation(
      Map<String, dynamic> data) async {
    final String endpoint = Api.ADD_DEMANDE_ATTESTATION;
    final url = Uri.parse(api + endpoint);
    Map<String, dynamic> result;
    final response = await http.post(
      url,
      body: data,
      headers: {
        'Authorization': "Bearer ${acteur!.token}",
      },
    );

    try {
      result = jsonDecode(response.body);
      return result;
    } catch (e) {
      print('Une erreur');
      return null;
    }
  }

  Future<Map<String, dynamic>?> addPlainte(Map<String, dynamic> data) async {
    final String endpoint = Api.ADD_PLAINTE;
    final url = Uri.parse(api + endpoint);
    final response = await http.post(
      url,
      body: data,
      headers: {
        'Authorization': "Bearer ${acteur!.token}",
      },
    );
    Map<String, dynamic>? result;
    print(response.body);

    try {
      result = jsonDecode(response.body);
      return result;
    } catch (e) {
      print("Une erreur");
      return null;
    }
  }

  Future<Map<String, dynamic>?> allPlaintes() async {
    final String endpoint = Api.ALL_PLAINTES;
    var url = Uri.parse(api + endpoint);
    final response = await http.get(
      url,
      headers: {
        'Authorization': "Bearer ${acteur!.token}",
        'Content-Type': 'application/json',
      },
    );

    Map<String, dynamic>? results;
    try {
      results = jsonDecode(response.body);
    } catch (e) {
      print("Une erreur inattendue s'est produite : $e");
    }
    return results;
  }
}

import 'dart:convert';

import '../../src/api.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../models/plainte.dart';

class PlainteRepository {
  final String api;
  const PlainteRepository({required this.api});

  Future<Map<String, dynamic>?> addDemandeAttestation(
      Map<String, dynamic> data) async {
    final String endpoint = Api.ADD_DEMANDE_ATTESTATION;
    final url = Uri.parse(api + endpoint);
    Map<String, dynamic>? result;
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      result = jsonDecode(response.body);
    }
    return result;
  }

  Future<Map<String, dynamic>?> addPlainte(Map<String, dynamic> data) async {
    final String endpoint = Api.ADD_PLAINTE;
    final url = Uri.parse(api + endpoint);
    final response = await http.post(url, body: data);
    Map<String, dynamic>? result;

    if (response.statusCode == 200) {
      result = jsonDecode(response.body);
    }
    return result;
  }

  Future<List<Plainte>> allPlaintes() async {
    List<Plainte> plaintes = [];
    final String endpoint = Api.ALL_PLAINTES;
    var url = Uri.parse(api + endpoint);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var result = await jsonDecode(response.body);
      if (result['code'] == Constants.SUCCESS) {
        for (var plainte in jsonDecode(result['plaintes'])) {
          plaintes.add(Plainte.fromJson(jsonDecode(plainte)));
        }
      }
    }
    return plaintes;
  }
}

import 'dart:convert';

import '../../src/api.dart';
import 'package:http/http.dart' as http;

class PlainteRepository {
  final String api;
  const PlainteRepository({required this.api});

  Future<Map<String, dynamic>> addDemandeAttestation(
      Map<String, dynamic> data) async {
    final String endpoint = Api.ADD_DEMANDE_ATTESTATION;
    final url = Uri.parse(api + endpoint);
    Map<String, dynamic> result;
    final response = await http.post(url, body: data);
    result = jsonDecode(response.body);

    return result;
  }

  Future<Map<String, dynamic>?> addPlainte(Map<String, dynamic> data) async {
    final String endpoint = Api.ADD_PLAINTE;
    final url = Uri.parse(api + endpoint);
    final response = await http.post(
      url,
      body: data,
      headers: {},
    );
    Map<String, dynamic>? result;

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
    final response = await http.get(url);

    Map<String, dynamic>? results;
    try {
      results = jsonDecode(response.body);
      return results;
    } catch (e) {
      print("Une erreur");
      return null;
    }
  }

  // Future<void> uploadPdf(Map<String, dynamic> data) async {
  //   final url = 'http://10.0.2.2:8000/api/upload-pdf';
  //   // Utilisez http.post pour envoyer le fichier PDF
  //   final response = await http.post(
  //     Uri.parse(url),
  //     body: data, // Ajoutez d'autres données si nécessaire
  //   );
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     print('Fichier PDF envoyé avec succès à Laravel');
  //   } else {
  //     print('Erreur lors de l\'envoi du fichier PDF à Laravel');
  //   }
  // }
}

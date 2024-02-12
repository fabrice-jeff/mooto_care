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
    print(response.body);
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
      var result = jsonDecode(response.body);
      if (result['code'] == Constants.SUCCESS) {
        for (var objet in jsonDecode(result['plaintes'])) {
          var objectJson = jsonDecode(objet);
          var acteur = jsonDecode(objectJson['acteur']);
          var fichier = jsonDecode(objectJson['fichier']);
          var typeType = jsonDecode(objectJson['type_type']);

          var bien = jsonDecode(objectJson['bien']);
          bien['acteur'] = acteur;
          bien['fichier'] = fichier;
          bien['type_couverture'] = typeType;

          var plainte = jsonDecode(objectJson['plainte']);
          plainte['bien'] = bien;

          plaintes.add(Plainte.fromJson(plainte));
        }
      }
    }
    return plaintes;
  }

  Future<void> uploadPdf(Map<String, dynamic> data) async {
    final url = 'http://10.0.2.2:8000/api/upload-pdf';
    // Utilisez http.post pour envoyer le fichier PDF
    final response = await http.post(
      Uri.parse(url),
      body: data, // Ajoutez d'autres données si nécessaire
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Fichier PDF envoyé avec succès à Laravel');
    } else {
      print('Erreur lors de l\'envoi du fichier PDF à Laravel');
    }
  }
}

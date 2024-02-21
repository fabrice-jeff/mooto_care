import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../src/api.dart';
import '../models/type_type.dart';

class BienRepository {
  final String api;
  BienRepository({required this.api});

  //  Ajouter un bien
  Future<Map<String, dynamic>> add(Map<String, dynamic> data) async {
    final endpoint = Api.ADD_BIEN;
    final url = Uri.parse(api + endpoint);
    final response = await http.post(
      url,
      body: data,
      headers: {},
    );
    Map<String, dynamic> result;
    result = jsonDecode(response.body);
    return result;
  }

  // Récupérer tous les biens de l'acteur connecté
  Future<Map<String, dynamic>?> allByActeur(data) async {
    final endpoint = Api.ALL_BIENS_BY_ACTEUR;
    final url = Uri.parse(api + endpoint);
    final Map<String, dynamic> results;
    final response = await http.post(
      url,
      body: data,
      headers: {},
    );
    try {
      results = jsonDecode(response.body);
      return results;
    } catch (e) {
      print("Une erreur");
      return null;
    }
  }

  // Récuperer un bien par son numéro  plaque
  Future<Map<String, dynamic>> getByNum(Map<String, dynamic> data) async {
    final endpoint = Api.BIEN_BY_NUM;
    final url = Uri.parse(api + endpoint);

    final response = await http.post(
      url,
      body: data,
      headers: {},
    );
    Map<String, dynamic> result;
    result = jsonDecode(response.body);
    return result;
  }

  Future<List<TypeType>> getCouvertures() async {
    final endpoint = Api.TYPE_COUVERTURE;
    final url = Uri.parse(api + endpoint);
    List<TypeType> couvertures = [];
    final response = await http.get(
      url,
      headers: {},
    );
    if (response.statusCode == 200) {
      var datas = jsonDecode(jsonDecode(response.body)['couvertures']);
      for (var couverture in datas) {
        couvertures.add(TypeType.fromJson(couverture));
      }
      // result = jsonDecode(response.body);
    }
    return couvertures;
  }

  // Assurer une moto
  Future<Map<String, dynamic>?> assureMoto(data) async {
    final endpoint = Api.ASSURE_BEIN;
    final url = Uri.parse(api + endpoint);
    final response = await http.post(
      url,
      body: data,
      headers: {},
    );
    Map<String, dynamic>? result;
    if (response.statusCode == 200) {
      result = jsonDecode(response.body);
    }
    return result;
  }
}

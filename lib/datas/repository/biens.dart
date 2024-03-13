import 'dart:convert';

import 'package:http/http.dart' as http;
import '../api.dart';
import '../../utils/share_preference.dart';
import '../models/acteur.dart';

class BienRepository {
  final String api;
  BienRepository({required this.api});
  Acteur? acteur = SharePreferences.getActeur();

  //  Ajouter un bien
  Future<Map<String, dynamic>?> add(Map<String, dynamic> data) async {
    final endpoint = Api.ADD_BIEN;
    final url = Uri.parse(api + endpoint);
    final response = await http.post(
      url,
      body: data,
      headers: {
        'Authorization': "Bearer ${acteur!.token}",
      },
    );
    Map<String, dynamic> result;
    try {
      result = jsonDecode(response.body);
      return result;
    } catch (e) {
      return null;
    }
  }

  // Récupérer tous les biens de l'acteur connecté
  Future<Map<String, dynamic>?> allByActeur(data) async {
    final endpoint = Api.ALL_BIENS_BY_ACTEUR;
    final url = Uri.parse(api + endpoint);
    final Map<String, dynamic> results;
    final response = await http.get(
      url,
      headers: {
        'Authorization': "Bearer ${acteur!.token}",
        'Content-Type': 'application/json',
      },
    );
    try {
      results = jsonDecode(response.body);
      return results;
    } catch (e) {
      return null;
    }
  }

  // Récuperer un bien par son numéro  plaque
  Future<Map<String, dynamic>?> getByNum(Map<String, dynamic> data) async {
    final endpoint = Api.BIEN_BY_NUM;
    final url = Uri.parse(
      api + endpoint,
    );

    final response = await http.post(
      url,
      body: data,
      headers: {
        'Authorization': "Bearer ${acteur!.token}",
      },
    );

    Map<String, dynamic>? result;
    try {
      result = jsonDecode(response.body);
      return result;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getCouvertures() async {
    final endpoint = Api.TYPE_COUVERTURE;
    final url = Uri.parse(api + endpoint);
    final response = await http.get(
      url,
      headers: {
        'Authorization': "Bearer ${acteur!.token}",
      },
    );
    try {
      var datas = jsonDecode(response.body);
      return datas;
    } catch (e) {
      return null;
    }
  }

  // Assurer une moto
  Future<Map<String, dynamic>?> assureMoto(data) async {
    final endpoint = Api.ASSURE_BEIN;
    final url = Uri.parse(api + endpoint);
    final response = await http.post(
      url,
      body: data,
      headers: {
        'Authorization': "Bearer ${acteur!.token}",
      },
    );
    Map<String, dynamic>? result;
    try {
      result = jsonDecode(response.body);
      return result;
    } catch (e) {
      return null;
    }
  }
}

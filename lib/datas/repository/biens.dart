import 'dart:convert';

import 'package:autocare/utils/constants.dart';
import 'package:http/http.dart' as http;
import '../../src/api/api.dart';
import '../models/bien.dart';

class BienRepository {
  final String api;
  BienRepository({required this.api});

  //  Ajouter un bien
  Future<Map<String, dynamic>?> add(Map<String, dynamic> data) async {
    final endpoint = Api.ADD_BIEN;
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

  // Récupérer tous les biens de l'acteur connecté
  Future<List<Bien>> all(data) async {
    final endpoint = Api.ALL_BIENS;
    final url = Uri.parse(api + endpoint);
    List<Bien> biens = [];
    final response = await http.post(
      url,
      body: data,
      headers: {},
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['code'] == Constants.SUCCESS) {
        var datas = jsonDecode(result['biens']);
        for (var bien in datas) {
          biens.add(Bien.fromJson(jsonDecode(bien)));
        }
      }
    }

    return biens;
  }
}

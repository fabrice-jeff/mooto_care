import 'dart:convert';

import 'package:autocare/utils/constants.dart';
import 'package:http/http.dart' as http;
import '../../src/api.dart';
import '../models/bien.dart';
import '../models/type_type.dart';

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
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      result = jsonDecode(response.body);
    }
    return result;
  }

  // Récupérer tous les biens de l'acteur connecté
  Future<List<Bien>> allByActeur(data) async {
    final endpoint = Api.ALL_BIENS_BY_ACTEUR;
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
          bien['acteur'] = jsonDecode(result['acteur']);
          biens.add(Bien.fromJson(bien));
        }
      }
    }

    return biens;
  }

  // Récuperer un bien par son numéro  plaque
  Future<Map<String, dynamic>?> getByNum(Map<String, dynamic> data) async {
    final endpoint = Api.BIEN_BY_NUM;
    final url = Uri.parse(api + endpoint);
    dynamic result;
    final response = await http.post(
      url,
      body: data,
      headers: {},
    );
    if (response.statusCode == 200) {
      result = jsonDecode(response.body);
    }
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
}

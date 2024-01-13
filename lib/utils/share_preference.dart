import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../datas/models/acteur.dart';

class SharePreferences {
  SharePreferences._();
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Acteur? getActeur() {
    String? acteurJson = prefs.getString('acteur');
    Acteur? acteur;
    if (acteurJson != null) {
      acteur = Acteur.fromJson(jsonDecode(acteurJson));
    }
    return acteur;
  }
}

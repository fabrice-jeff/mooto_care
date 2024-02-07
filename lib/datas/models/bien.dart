import '../../services/datetime_format.dart';
import 'acteur.dart';

class Bien {
  final int? id;
  final String code;
  final String nomBien;
  final DateTime dateAcquisition;
  final String numPlaque;
  final String numChassis;
  final String adresse;
  final Acteur acteur;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool deleted;
  final int typeCouverture;
  final bool promotion;
  Bien({
    this.id,
    required this.code,
    required this.nomBien,
    required this.dateAcquisition,
    required this.numPlaque,
    required this.numChassis,
    required this.adresse,
    required this.acteur,
    required this.createdAt,
    required this.updatedAt,
    this.deleted = false,
    required this.typeCouverture,
    this.promotion = false,
  });
  factory Bien.fromJson(json) {
    Acteur acteur = Acteur.fromJson(json['acteur']);
    return Bien(
      code: json['code'],
      nomBien: json['nom_bien'],
      dateAcquisition: dateTimeFormat(json['date_acquisition']),
      numPlaque: json['num_plaque'],
      numChassis: json['num_chassis'],
      adresse: json['adresse'],
      acteur: acteur,
      createdAt: dateTimeFormat(json['created_at']),
      updatedAt: dateTimeFormat(json['updated_at']),
      typeCouverture: json['type_couverture'],
      promotion: (json['promotion'] == 0) ? false : true,
    );
  }
}

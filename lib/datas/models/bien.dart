import '../../services/datetime_format.dart';
import 'acteur.dart';
import 'fichier.dart';
import 'status.dart';
import 'type_type.dart';

class Bien {
  final int? id;
  final String code;
  final String nomBien;
  final DateTime dateAcquisition;
  final String numPlaque;
  final String numChassis;
  final Fichier fichier;
  final Acteur acteur;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool deleted;
  final TypeType typeCouverture;
  final bool promotion;
  final Status? status;
  Bien({
    this.id,
    required this.code,
    required this.nomBien,
    required this.dateAcquisition,
    required this.numPlaque,
    required this.numChassis,
    required this.fichier,
    required this.acteur,
    required this.createdAt,
    required this.updatedAt,
    this.deleted = false,
    required this.typeCouverture,
    this.promotion = false,
    this.status,
  });
  factory Bien.fromJson(json) {
    Acteur acteur = Acteur.fromJson(json['acteur']);
    Fichier fichier = Fichier.fromJson(json['fichier']);
    TypeType typeType = TypeType.fromJson(json['type_couverture']);
    Status status = Status.fromJson(json['status']);
    return Bien(
      code: json['code'],
      nomBien: json['nom_bien'],
      dateAcquisition: dateTimeFormat(json['date_acquisition']),
      numPlaque: json['num_plaque'],
      numChassis: json['num_chassis'],
      acteur: acteur,
      fichier: fichier,
      createdAt: dateTimeFormat(json['created_at']),
      updatedAt: dateTimeFormat(json['updated_at']),
      typeCouverture: typeType,
      status: status,
      promotion: (json['promotion'] == 0) ? false : true,
    );
  }
}

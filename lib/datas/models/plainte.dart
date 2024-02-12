import '../../services/datetime_format.dart';
import 'bien.dart';
import 'fichier.dart';

class Plainte {
  final int? id;
  final String code;
  final DateTime datePerte;
  // final String numeroPlaque;
  // final String numeroChassis;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool disabled;
  final Bien bien;

  Plainte({
    this.id,
    required this.code,
    required this.datePerte,
    // required this.numeroPlaque,
    // required this.numeroChassis,
    required this.createdAt,
    required this.updatedAt,
    required this.disabled,
    required this.bien,
  });

  factory Plainte.fromJson(Map<String, dynamic> json) {
    Bien bien = Bien.fromJson(json['bien']);
    return Plainte(
      code: json['code'],
      datePerte: dateTimeFormat(json['date_perte']),
      // numeroPlaque: json['numero_plaque'],
      // numeroChassis: json['numero_chassis'],
      createdAt: dateTimeFormat(json['created_at']),
      updatedAt: dateTimeFormat(json['updated_at']),
      disabled: (json['disabled'] == 0) ? false : true,
      bien: bien,
    );
  }
}

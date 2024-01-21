import 'dart:convert';

import '../../services/datetime_format.dart';
import 'bien.dart';

class Plainte {
  final int? id;
  final String code;
  final String nomBien;
  final DateTime datePerte;
  final String numeroPlaque;
  final String numeroChassis;
  final String? attestation;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool disabled;
  final Bien bien;

  Plainte({
    this.id,
    required this.code,
    required this.nomBien,
    required this.datePerte,
    required this.numeroPlaque,
    required this.numeroChassis,
    this.attestation,
    required this.createdAt,
    required this.updatedAt,
    required this.disabled,
    required this.bien,
  });

  factory Plainte.fromJson(Map<String, dynamic> json) {
    Bien bien = Bien.fromJson(jsonDecode(json['bien']));
    print(json['updated_at']);
    return Plainte(
      code: json['code'],
      nomBien: json['nom_bien'],
      datePerte: dateTimeFormat(json['date_perte']['date']),
      numeroPlaque: json['numero_plaque'],
      numeroChassis: json['numero_chassis'],
      createdAt: dateTimeFormat(json['created_at']['date']),
      updatedAt: dateTimeFormat(json['updated_at']['date']),
      disabled: json['disabled'],
      bien: bien,
    );
  }
}

import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../../services/datetime_format.dart';
import 'bien.dart';

class DemandeAttestation {
  final int id;
  final String nom;
  final String prenoms;
  final String code;
  final DateTime datePerte;
  final String description;
  final bool cancel;
  final Bien bien;
  final DateTime createdAt;
  final DateTime updatedAt;
  DemandeAttestation({
    required this.id,
    required this.nom,
    required this.prenoms,
    required this.code,
    required this.datePerte,
    required this.description,
    required this.cancel,
    required this.createdAt,
    required this.updatedAt,
    required this.bien,
  });
  factory DemandeAttestation.fromJson(Map<String, dynamic> json) {
    Bien bien = Bien.fromJson(json['bien']);
    return DemandeAttestation(
      id: json['id'],
      nom: json['nom'],
      prenoms: json['prenoms'],
      code: json['code'],
      datePerte: dateTimeFormat(json['date_perte']),
      description: json['description'],
      cancel: (json['cancel'] == 0) ? false : true,
      createdAt: dateTimeFormat(json['created_at']),
      updatedAt: dateTimeFormat(json['updated_at']),
      bien: bien,
    );
  }
}

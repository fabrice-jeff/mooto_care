import '../../services/datetime_format.dart';
import 'bien.dart';
import 'fichier.dart';

class DemandeAttestation {
  final int id;
  final String code;
  final DateTime datePerte;
  final String description;
  final Fichier fichier;
  final Bien bien;
  final DateTime createdAt;
  final DateTime updatedAt;

  DemandeAttestation({
    required this.id,
    required this.code,
    required this.datePerte,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.bien,
    required this.fichier,
  });
  factory DemandeAttestation.fromJson(Map<String, dynamic> json) {
    Bien bien = Bien.fromJson(json['bien']);
    return DemandeAttestation(
      id: json['id'],
      // nom: json['nom'],
      // prenoms: json['prenoms'],
      code: json['code'],
      datePerte: dateTimeFormat(json['date_perte']),
      description: json['description'],
      createdAt: dateTimeFormat(json['created_at']),
      updatedAt: dateTimeFormat(json['updated_at']),
      bien: bien,
      fichier: json['fichier'],
    );
  }
}

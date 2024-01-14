import '../../services/datetime_format.dart';

class Acteur {
  final int? id;
  final String nom;
  final String prenoms;
  final String telephone;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String code;
  final String? photo;
  Acteur({
    this.id,
    required this.code,
    required this.nom,
    required this.prenoms,
    required this.telephone,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    this.photo,
  });

  factory Acteur.fromJson(Map<String, dynamic> json) {
    return Acteur(
      code: json['code'],
      nom: json['nom'],
      prenoms: json['prenoms'],
      telephone: json['telephone'],
      email: json['email'],
      createdAt: dateTimeFormat(json['created_at']['date']),
      updatedAt: dateTimeFormat(json['updated_at']['date']),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        'nom': nom,
        'prenoms': prenoms,
        'code': code,
        'telephone': telephone,
        'email': email,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

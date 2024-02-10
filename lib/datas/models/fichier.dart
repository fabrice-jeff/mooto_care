import '../../services/datetime_format.dart';

class Fichier {
  final int? id;
  final String code;
  final String path;
  final String extension;
  final DateTime createdAt;
  final DateTime updatedAt;

  Fichier({
    this.id,
    required this.code,
    required this.path,
    required this.extension,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Fichier.fromJson(Map<String, dynamic> json) => Fichier(
        code: json['code'],
        path: json['path'],
        extension: json['extension'],
        createdAt: dateTimeFormat(json['created_at']),
        updatedAt: dateTimeFormat(json['updated_at']),
      );
}

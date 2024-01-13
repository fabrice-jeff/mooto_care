import 'acteur.dart';

class User {
  final int? id;
  final Acteur acteur;
  final String username;
  final String password;
  final bool valid;
  final DateTime createdAt;
  final DateTime updatedAt;
  User({
    this.id,
    required this.username,
    required this.acteur,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    this.valid = false,
  });
}

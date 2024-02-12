class Status {
  final int? id;
  final String code;
  final String libelle;
  const Status({
    this.id,
    required this.code,
    required this.libelle,
  });
  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json['code'],
        libelle: json['libelle'],
      );
}

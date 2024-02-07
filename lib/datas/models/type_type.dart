class TypeType {
  final int? id;
  final String codeReference;
  final String libelle;
  const TypeType({
    required this.codeReference,
    required this.libelle,
    this.id,
  });

  factory TypeType.fromJson(Map<String, dynamic> json) => TypeType(
        codeReference: json['code_reference'],
        libelle: json['libelle'],
      );
}

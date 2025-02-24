import 'dart:convert';

class SessionType {
  final String typeId;
  final String name;
  final String code;
  final bool isMandatory;
  final int maxAbsences;

  SessionType({
    required this.typeId,
    required this.name,
    required this.code,
    required this.isMandatory,
    required this.maxAbsences,
  });

  Map<String, dynamic> toMap() {
    return {
      'type_id': typeId,
      'name': name,
      'code': code,
      'is_mandatory': isMandatory,
      'max_absences': maxAbsences,
    };
  }

  factory SessionType.fromMap(Map<String, dynamic> map) {
    return SessionType(
      typeId: map['type_id'] ?? '',
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      isMandatory: map['is_mandatory'] ?? false,
      maxAbsences: map['max_absences']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionType.fromJson(String source) =>
      SessionType.fromMap(json.decode(source));

  SessionType copyWith({
    String? typeId,
    String? name,
    String? code,
    bool? isMandatory,
    int? maxAbsences,
  }) {
    return SessionType(
      typeId: typeId ?? this.typeId,
      name: name ?? this.name,
      code: code ?? this.code,
      isMandatory: isMandatory ?? this.isMandatory,
      maxAbsences: maxAbsences ?? this.maxAbsences,
    );
  }
}

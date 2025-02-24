import 'dart:convert';

class Student {
  final String studentId;
  final String userId;
  final String name;
  final String groupName;
  final String faculty;
  final String specialty;
  final int year;

  Student({
    required this.studentId,
    required this.userId,
    required this.name,
    required this.groupName,
    required this.faculty,
    required this.specialty,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'student_id': studentId,
      'user_id': userId,
      'name': name,
      'group_name': groupName,
      'faculty': faculty,
      'specialty': specialty,
      'year': year,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      studentId: map['student_id'] ?? '',
      userId: map['user_id']?.toString() ?? '',
      name: map['name'] ?? '',
      groupName: map['group_name'] ?? '',
      faculty: map['faculty'] ?? '',
      specialty: map['specialty'] ?? '',
      year: map['year']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) => Student.fromMap(json.decode(source));

  Student copyWith({
    String? studentId,
    String? userId,
    String? name,
    String? groupName,
    String? faculty,
    String? specialty,
    int? year,
  }) {
    return Student(
      studentId: studentId ?? this.studentId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      groupName: groupName ?? this.groupName,
      faculty: faculty ?? this.faculty,
      specialty: specialty ?? this.specialty,
      year: year ?? this.year,
    );
  }
}

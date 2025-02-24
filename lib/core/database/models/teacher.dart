import 'dart:convert';

class Teacher {
  final String teacherId;
  final String userId;
  final String name;
  final String department;
  final String email;

  Teacher({
    required this.teacherId,
    required this.userId,
    required this.name,
    required this.department,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'teacher_id': teacherId,
      'user_id': userId,
      'name': name,
      'department': department,
      'email': email,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      teacherId: map['teacher_id'] ?? '',
      userId: map['user_id']?.toString() ?? '',
      name: map['name'] ?? '',
      department: map['department'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Teacher.fromJson(String source) => Teacher.fromMap(json.decode(source));

  Teacher copyWith({
    String? teacherId,
    String? userId,
    String? name,
    String? department,
    String? email,
  }) {
    return Teacher(
      teacherId: teacherId ?? this.teacherId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      department: department ?? this.department,
      email: email ?? this.email,
    );
  }
}

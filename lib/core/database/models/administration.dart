import 'dart:convert';

class Administration {
  final String adminId;
  final String userId;
  final String name;
  final String department;
  final String role;
  final String email;

  Administration({
    required this.adminId,
    required this.userId,
    required this.name,
    required this.department,
    required this.role,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'admin_id': adminId,
      'user_id': userId,
      'name': name,
      'department': department,
      'role': role,
      'email': email,
    };
  }

  factory Administration.fromMap(Map<String, dynamic> map) {
    return Administration(
      adminId: map['admin_id'] ?? '',
      userId: map['user_id']?.toString() ?? '',
      name: map['name'] ?? '',
      department: map['department'] ?? '',
      role: map['role'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Administration.fromJson(String source) =>
      Administration.fromMap(json.decode(source));

  Administration copyWith({
    String? adminId,
    String? userId,
    String? name,
    String? department,
    String? role,
    String? email,
  }) {
    return Administration(
      adminId: adminId ?? this.adminId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      department: department ?? this.department,
      role: role ?? this.role,
      email: email ?? this.email,
    );
  }
}

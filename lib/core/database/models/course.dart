import 'dart:convert';

class Course {
  final String courseId;
  final String name;
  final String semester;
  final String academicYear;
  final String faculty;

  Course({
    required this.courseId,
    required this.name,
    required this.semester,
    required this.academicYear,
    required this.faculty,
  });

  Map<String, dynamic> toMap() {
    return {
      'course_id': courseId,
      'name': name,
      'semester': semester,
      'academic_year': academicYear,
      'faculty': faculty,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      courseId: map['course_id'] ?? '',
      name: map['name'] ?? '',
      semester: map['semester'] ?? '',
      academicYear: map['academic_year'] ?? '',
      faculty: map['faculty'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  Course copyWith({
    String? courseId,
    String? name,
    String? semester,
    String? academicYear,
    String? faculty,
  }) {
    return Course(
      courseId: courseId ?? this.courseId,
      name: name ?? this.name,
      semester: semester ?? this.semester,
      academicYear: academicYear ?? this.academicYear,
      faculty: faculty ?? this.faculty,
    );
  }
}

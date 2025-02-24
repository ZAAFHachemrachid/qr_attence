import 'dart:convert';

class CourseSessionType {
  final String courseSessionTypeId;
  final String courseId;
  final String typeId;
  final String semester;
  final int maxAbsences;

  CourseSessionType({
    required this.courseSessionTypeId,
    required this.courseId,
    required this.typeId,
    required this.semester,
    required this.maxAbsences,
  });

  Map<String, dynamic> toMap() {
    return {
      'course_session_type_id': courseSessionTypeId,
      'course_id': courseId,
      'type_id': typeId,
      'semester': semester,
      'max_absences': maxAbsences,
    };
  }

  factory CourseSessionType.fromMap(Map<String, dynamic> map) {
    return CourseSessionType(
      courseSessionTypeId: map['course_session_type_id'] ?? '',
      courseId: map['course_id'] ?? '',
      typeId: map['type_id'] ?? '',
      semester: map['semester'] ?? '',
      maxAbsences: map['max_absences']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseSessionType.fromJson(String source) =>
      CourseSessionType.fromMap(json.decode(source));

  CourseSessionType copyWith({
    String? courseSessionTypeId,
    String? courseId,
    String? typeId,
    String? semester,
    int? maxAbsences,
  }) {
    return CourseSessionType(
      courseSessionTypeId: courseSessionTypeId ?? this.courseSessionTypeId,
      courseId: courseId ?? this.courseId,
      typeId: typeId ?? this.typeId,
      semester: semester ?? this.semester,
      maxAbsences: maxAbsences ?? this.maxAbsences,
    );
  }
}

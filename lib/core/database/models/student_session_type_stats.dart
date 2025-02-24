import 'dart:convert';

class StudentSessionTypeStats {
  final String statId;
  final String studentId;
  final String courseSessionTypeId;
  final int totalSessions;
  final int totalPresent;
  final int totalAbsent;
  final int justifiedAbsences;
  final int unjustifiedAbsences;

  StudentSessionTypeStats({
    required this.statId,
    required this.studentId,
    required this.courseSessionTypeId,
    required this.totalSessions,
    required this.totalPresent,
    required this.totalAbsent,
    required this.justifiedAbsences,
    required this.unjustifiedAbsences,
  });

  Map<String, dynamic> toMap() {
    return {
      'stat_id': statId,
      'student_id': studentId,
      'course_session_type_id': courseSessionTypeId,
      'total_sessions': totalSessions,
      'total_present': totalPresent,
      'total_absent': totalAbsent,
      'justified_absences': justifiedAbsences,
      'unjustified_absences': unjustifiedAbsences,
    };
  }

  factory StudentSessionTypeStats.fromMap(Map<String, dynamic> map) {
    return StudentSessionTypeStats(
      statId: map['stat_id'] ?? '',
      studentId: map['student_id'] ?? '',
      courseSessionTypeId: map['course_session_type_id'] ?? '',
      totalSessions: map['total_sessions']?.toInt() ?? 0,
      totalPresent: map['total_present']?.toInt() ?? 0,
      totalAbsent: map['total_absent']?.toInt() ?? 0,
      justifiedAbsences: map['justified_absences']?.toInt() ?? 0,
      unjustifiedAbsences: map['unjustified_absences']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentSessionTypeStats.fromJson(String source) =>
      StudentSessionTypeStats.fromMap(json.decode(source));

  StudentSessionTypeStats copyWith({
    String? statId,
    String? studentId,
    String? courseSessionTypeId,
    int? totalSessions,
    int? totalPresent,
    int? totalAbsent,
    int? justifiedAbsences,
    int? unjustifiedAbsences,
  }) {
    return StudentSessionTypeStats(
      statId: statId ?? this.statId,
      studentId: studentId ?? this.studentId,
      courseSessionTypeId: courseSessionTypeId ?? this.courseSessionTypeId,
      totalSessions: totalSessions ?? this.totalSessions,
      totalPresent: totalPresent ?? this.totalPresent,
      totalAbsent: totalAbsent ?? this.totalAbsent,
      justifiedAbsences: justifiedAbsences ?? this.justifiedAbsences,
      unjustifiedAbsences: unjustifiedAbsences ?? this.unjustifiedAbsences,
    );
  }

  double get attendancePercentage =>
      totalSessions > 0 ? (totalPresent / totalSessions) * 100 : 0;
}

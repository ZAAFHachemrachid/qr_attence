import 'dart:convert';

class AttendanceRecord {
  final String recordId;
  final String sessionId;
  final String studentId;
  final String status;
  final DateTime timestamp;
  final bool isLateArrival;

  AttendanceRecord({
    required this.recordId,
    required this.sessionId,
    required this.studentId,
    required this.status,
    required this.timestamp,
    required this.isLateArrival,
  });

  Map<String, dynamic> toMap() {
    return {
      'record_id': recordId,
      'session_id': sessionId,
      'student_id': studentId,
      'status': status,
      'timestamp': timestamp.toUtc().toIso8601String(),
      'is_late_arrival': isLateArrival,
    };
  }

  factory AttendanceRecord.fromMap(Map<String, dynamic> map) {
    return AttendanceRecord(
      recordId: map['record_id'] ?? '',
      sessionId: map['session_id'] ?? '',
      studentId: map['student_id'] ?? '',
      status: map['status'] ?? '',
      timestamp: DateTime.parse(map['timestamp']).toLocal(),
      isLateArrival: map['is_late_arrival'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceRecord.fromJson(String source) =>
      AttendanceRecord.fromMap(json.decode(source));

  AttendanceRecord copyWith({
    String? recordId,
    String? sessionId,
    String? studentId,
    String? status,
    DateTime? timestamp,
    bool? isLateArrival,
  }) {
    return AttendanceRecord(
      recordId: recordId ?? this.recordId,
      sessionId: sessionId ?? this.sessionId,
      studentId: studentId ?? this.studentId,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      isLateArrival: isLateArrival ?? this.isLateArrival,
    );
  }
}

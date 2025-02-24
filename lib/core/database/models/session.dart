import 'dart:convert';

class Session {
  final String sessionId;
  final String courseSessionTypeId;
  final String teacherId;
  final String location;
  final String groupId;
  final DateTime scheduledTime;
  final Duration duration;
  final Duration qrCodeValidityDuration;
  final bool isActive;

  Session({
    required this.sessionId,
    required this.courseSessionTypeId,
    required this.teacherId,
    required this.location,
    required this.groupId,
    required this.scheduledTime,
    required this.duration,
    required this.qrCodeValidityDuration,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'session_id': sessionId,
      'course_session_type_id': courseSessionTypeId,
      'teacher_id': teacherId,
      'location': location,
      'group_id': groupId,
      'scheduled_time': scheduledTime.toUtc().toIso8601String(),
      'duration': duration.inSeconds,
      'qr_code_validity_duration': qrCodeValidityDuration.inSeconds,
      'is_active': isActive,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      sessionId: map['session_id'] ?? '',
      courseSessionTypeId: map['course_session_type_id'] ?? '',
      teacherId: map['teacher_id'] ?? '',
      location: map['location'] ?? '',
      groupId: map['group_id'] ?? '',
      scheduledTime: DateTime.parse(map['scheduled_time']).toLocal(),
      duration: Duration(seconds: map['duration'] ?? 0),
      qrCodeValidityDuration: Duration(seconds: map['qr_code_validity_duration'] ?? 0),
      isActive: map['is_active'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) => Session.fromMap(json.decode(source));

  Session copyWith({
    String? sessionId,
    String? courseSessionTypeId,
    String? teacherId,
    String? location,
    String? groupId,
    DateTime? scheduledTime,
    Duration? duration,
    Duration? qrCodeValidityDuration,
    bool? isActive,
  }) {
    return Session(
      sessionId: sessionId ?? this.sessionId,
      courseSessionTypeId: courseSessionTypeId ?? this.courseSessionTypeId,
      teacherId: teacherId ?? this.teacherId,
      location: location ?? this.location,
      groupId: groupId ?? this.groupId,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      duration: duration ?? this.duration,
      qrCodeValidityDuration: qrCodeValidityDuration ?? this.qrCodeValidityDuration,
      isActive: isActive ?? this.isActive,
    );
  }
}

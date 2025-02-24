import 'dart:convert';

class QRCode {
  final String qrId;
  final String sessionId;
  final DateTime generatedTime;
  final Duration validityDuration;

  QRCode({
    required this.qrId,
    required this.sessionId,
    required this.generatedTime,
    required this.validityDuration,
  });

  Map<String, dynamic> toMap() {
    return {
      'qr_id': qrId,
      'session_id': sessionId,
      'generated_time': generatedTime.toUtc().toIso8601String(),
      'validity_duration': validityDuration.inSeconds,
    };
  }

  factory QRCode.fromMap(Map<String, dynamic> map) {
    return QRCode(
      qrId: map['qr_id'] ?? '',
      sessionId: map['session_id'] ?? '',
      generatedTime: DateTime.parse(map['generated_time']).toLocal(),
      validityDuration: Duration(seconds: map['validity_duration'] ?? 0),
    );
  }

  String toJson() => json.encode(toMap());

  factory QRCode.fromJson(String source) => QRCode.fromMap(json.decode(source));

  QRCode copyWith({
    String? qrId,
    String? sessionId,
    DateTime? generatedTime,
    Duration? validityDuration,
  }) {
    return QRCode(
      qrId: qrId ?? this.qrId,
      sessionId: sessionId ?? this.sessionId,
      generatedTime: generatedTime ?? this.generatedTime,
      validityDuration: validityDuration ?? this.validityDuration,
    );
  }

  bool get isValid {
    final now = DateTime.now();
    return now.difference(generatedTime) <= validityDuration;
  }
}

import '../models/attendance_record.dart';
import 'base_repository.dart';

class AttendanceRecordRepository extends BaseRepository<AttendanceRecord> {
  AttendanceRecordRepository() : super('attendance_record');

  Future<AttendanceRecord?> getAttendanceRecordById(String id) async {
    final data = await getById(id);
    if (data == null) return null;
    return AttendanceRecord.fromMap(data);
  }

  Future<List<AttendanceRecord>> getAllAttendanceRecords() async {
    final data = await getAll();
    return data.map((e) => AttendanceRecord.fromMap(e)).toList();
  }

  Future<List<AttendanceRecord>> getAttendanceRecordsBySession(
    String sessionId,
  ) async {
    final data = await query('session_id', sessionId);
    return data.map((e) => AttendanceRecord.fromMap(e)).toList();
  }

  Future<List<AttendanceRecord>> getAttendanceRecordsByStudent(
    String studentId,
  ) async {
    final data = await query('student_id', studentId);
    return data.map((e) => AttendanceRecord.fromMap(e)).toList();
  }

  Future<AttendanceRecord> createAttendanceRecord(
    AttendanceRecord record,
  ) async {
    final data = await create(record.toMap());
    return AttendanceRecord.fromMap(data);
  }

  Future<AttendanceRecord> updateAttendanceRecord(
    AttendanceRecord record,
  ) async {
    final data = await update(record.recordId, record.toMap());
    return AttendanceRecord.fromMap(data);
  }

  Future<void> deleteAttendanceRecord(String recordId) async {
    await delete(recordId);
  }

  Future<List<AttendanceRecord>> getAttendanceRecordsByStatus(
    String status,
  ) async {
    final data = await query('status', status);
    return data.map((e) => AttendanceRecord.fromMap(e)).toList();
  }

  Future<List<AttendanceRecord>> getAttendanceRecordsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final response = await table
        .select()
        .gte('timestamp', startDate.toUtc().toIso8601String())
        .lte('timestamp', endDate.toUtc().toIso8601String())
        .order('timestamp');
    return response.map((e) => AttendanceRecord.fromMap(e)).toList();
  }

  Future<List<AttendanceRecord>> getLateArrivals() async {
    final data = await query('is_late_arrival', true);
    return data.map((e) => AttendanceRecord.fromMap(e)).toList();
  }

  Future<bool> hasAttendedSession(String sessionId, String studentId) async {
    final response = await table
        .select()
        .eq('session_id', sessionId)
        .eq('student_id', studentId);
    return response.isNotEmpty;
  }
}

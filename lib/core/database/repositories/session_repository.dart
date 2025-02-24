import '../models/session.dart';
import 'base_repository.dart';

class SessionRepository extends BaseRepository<Session> {
  SessionRepository() : super('session');

  Future<Session?> getSessionById(String id) async {
    final data = await getById(id);
    if (data == null) return null;
    return Session.fromMap(data);
  }

  Future<List<Session>> getAllSessions() async {
    final data = await getAll();
    return data.map((e) => Session.fromMap(e)).toList();
  }

  Future<List<Session>> getSessionsByTeacher(String teacherId) async {
    final data = await query('teacher_id', teacherId);
    return data.map((e) => Session.fromMap(e)).toList();
  }

  Future<List<Session>> getSessionsByGroup(String groupId) async {
    final data = await query('group_id', groupId);
    return data.map((e) => Session.fromMap(e)).toList();
  }

  Future<List<Session>> getSessionsByLocation(String location) async {
    final data = await query('location', location);
    return data.map((e) => Session.fromMap(e)).toList();
  }

  Future<List<Session>> getActiveSessions() async {
    final data = await query('is_active', true);
    return data.map((e) => Session.fromMap(e)).toList();
  }

  Future<Session> createSession(Session session) async {
    final data = await create(session.toMap());
    return Session.fromMap(data);
  }

  Future<Session> updateSession(Session session) async {
    final data = await update(session.sessionId, session.toMap());
    return Session.fromMap(data);
  }

  Future<void> deleteSession(String sessionId) async {
    await delete(sessionId);
  }

  Future<List<Session>> getSessionsByCourseSessionType(
    String courseSessionTypeId,
  ) async {
    final data = await query('course_session_type_id', courseSessionTypeId);
    return data.map((e) => Session.fromMap(e)).toList();
  }

  Future<List<Session>> getUpcomingSessions() async {
    final now = DateTime.now().toUtc().toIso8601String();
    final response = await table
        .select()
        .gt('scheduled_time', now)
        .order('scheduled_time');
    return response.map((e) => Session.fromMap(e)).toList();
  }

  Future<List<Session>> getSessionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final response = await table
        .select()
        .gte('scheduled_time', startDate.toUtc().toIso8601String())
        .lte('scheduled_time', endDate.toUtc().toIso8601String())
        .order('scheduled_time');
    return response.map((e) => Session.fromMap(e)).toList();
  }
}

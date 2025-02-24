import '../models/student_session_type_stats.dart';
import 'base_repository.dart';

class StudentSessionTypeStatsRepository
    extends BaseRepository<StudentSessionTypeStats> {
  StudentSessionTypeStatsRepository() : super('student_session_type_stats');

  Future<StudentSessionTypeStats?> getStatById(String id) async {
    final data = await getById(id);
    if (data == null) return null;
    return StudentSessionTypeStats.fromMap(data);
  }

  Future<List<StudentSessionTypeStats>> getAllStats() async {
    final data = await getAll();
    return data.map((e) => StudentSessionTypeStats.fromMap(e)).toList();
  }

  Future<List<StudentSessionTypeStats>> getStatsByStudent(
    String studentId,
  ) async {
    final data = await query('student_id', studentId);
    return data.map((e) => StudentSessionTypeStats.fromMap(e)).toList();
  }

  Future<List<StudentSessionTypeStats>> getStatsByCourseSessionType(
    String courseSessionTypeId,
  ) async {
    final data = await query('course_session_type_id', courseSessionTypeId);
    return data.map((e) => StudentSessionTypeStats.fromMap(e)).toList();
  }

  Future<StudentSessionTypeStats?> getStudentStats(
    String studentId,
    String courseSessionTypeId,
  ) async {
    final response = await table
        .select()
        .eq('student_id', studentId)
        .eq('course_session_type_id', courseSessionTypeId);
    if (response.isEmpty) return null;
    return StudentSessionTypeStats.fromMap(response.first);
  }

  Future<StudentSessionTypeStats> createStats(
    StudentSessionTypeStats stats,
  ) async {
    final data = await create(stats.toMap());
    return StudentSessionTypeStats.fromMap(data);
  }

  Future<StudentSessionTypeStats> updateStats(
    StudentSessionTypeStats stats,
  ) async {
    final data = await update(stats.statId, stats.toMap());
    return StudentSessionTypeStats.fromMap(data);
  }

  Future<void> deleteStats(String statId) async {
    await delete(statId);
  }

  Future<List<StudentSessionTypeStats>> getStudentsAtRisk({
    required double attendanceThreshold,
  }) async {
    final allStats = await getAllStats();
    return allStats
        .where((stats) => stats.attendancePercentage < attendanceThreshold)
        .toList();
  }

  Future<Map<String, List<StudentSessionTypeStats>>>
  groupStatsByCourseSessionType(List<String> courseSessionTypeIds) async {
    final response = await table.select().inFilter(
      'course_session_type_id',
      courseSessionTypeIds,
    );

    final Map<String, List<StudentSessionTypeStats>> groupedStats = {};
    for (final data in response) {
      final stats = StudentSessionTypeStats.fromMap(data);
      groupedStats.putIfAbsent(stats.courseSessionTypeId, () => []).add(stats);
    }
    return groupedStats;
  }
}

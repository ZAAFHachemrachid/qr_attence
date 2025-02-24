import '../models/course_session_type.dart';
import 'base_repository.dart';

class CourseSessionTypeRepository extends BaseRepository<CourseSessionType> {
  CourseSessionTypeRepository() : super('course_session_type');

  Future<CourseSessionType?> getCourseSessionTypeById(String id) async {
    final data = await getById(id);
    if (data == null) return null;
    return CourseSessionType.fromMap(data);
  }

  Future<List<CourseSessionType>> getAllCourseSessionTypes() async {
    final data = await getAll();
    return data.map((e) => CourseSessionType.fromMap(e)).toList();
  }

  Future<List<CourseSessionType>> getCourseSessionTypesByCourseId(
    String courseId,
  ) async {
    final data = await query('course_id', courseId);
    return data.map((e) => CourseSessionType.fromMap(e)).toList();
  }

  Future<List<CourseSessionType>> getCourseSessionTypesByTypeId(
    String typeId,
  ) async {
    final data = await query('type_id', typeId);
    return data.map((e) => CourseSessionType.fromMap(e)).toList();
  }

  Future<List<CourseSessionType>> getCourseSessionTypesBySemester(
    String semester,
  ) async {
    final data = await query('semester', semester);
    return data.map((e) => CourseSessionType.fromMap(e)).toList();
  }

  Future<CourseSessionType> createCourseSessionType(
    CourseSessionType courseSessionType,
  ) async {
    final data = await create(courseSessionType.toMap());
    return CourseSessionType.fromMap(data);
  }

  Future<CourseSessionType> updateCourseSessionType(
    CourseSessionType courseSessionType,
  ) async {
    final data = await update(
      courseSessionType.courseSessionTypeId,
      courseSessionType.toMap(),
    );
    return CourseSessionType.fromMap(data);
  }

  Future<void> deleteCourseSessionType(String courseSessionTypeId) async {
    await delete(courseSessionTypeId);
  }

  Future<List<CourseSessionType>> getCourseSessionTypesByMaxAbsences(
    int maxAbsences,
  ) async {
    final data = await query('max_absences', maxAbsences);
    return data.map((e) => CourseSessionType.fromMap(e)).toList();
  }
}

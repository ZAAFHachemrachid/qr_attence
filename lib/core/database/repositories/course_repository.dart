import '../models/course.dart';
import 'base_repository.dart';

class CourseRepository extends BaseRepository<Course> {
  CourseRepository() : super('course');

  Future<Course?> getCourseById(String id) async {
    final data = await getById(id);
    if (data == null) return null;
    return Course.fromMap(data);
  }

  Future<List<Course>> getAllCourses() async {
    final data = await getAll();
    return data.map((e) => Course.fromMap(e)).toList();
  }

  Future<List<Course>> getCoursesByFaculty(String faculty) async {
    final data = await query('faculty', faculty);
    return data.map((e) => Course.fromMap(e)).toList();
  }

  Future<List<Course>> getCoursesBySemester(String semester) async {
    final data = await query('semester', semester);
    return data.map((e) => Course.fromMap(e)).toList();
  }

  Future<Course> createCourse(Course course) async {
    final data = await create(course.toMap());
    return Course.fromMap(data);
  }

  Future<Course> updateCourse(Course course) async {
    final data = await update(course.courseId, course.toMap());
    return Course.fromMap(data);
  }

  Future<void> deleteCourse(String courseId) async {
    await delete(courseId);
  }

  Future<List<Course>> getCoursesByAcademicYear(String academicYear) async {
    final data = await query('academic_year', academicYear);
    return data.map((e) => Course.fromMap(e)).toList();
  }
}

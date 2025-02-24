import '../models/teacher.dart';
import 'base_repository.dart';

class TeacherRepository extends BaseRepository<Teacher> {
  TeacherRepository() : super('teacher');

  Future<Teacher?> getTeacherById(String id) async {
    final data = await getById(id);
    if (data == null) return null;
    return Teacher.fromMap(data);
  }

  Future<List<Teacher>> getAllTeachers() async {
    final data = await getAll();
    return data.map((e) => Teacher.fromMap(e)).toList();
  }

  Future<Teacher?> getTeacherByUserId(String userId) async {
    final data = await query('user_id', userId);
    if (data.isEmpty) return null;
    return Teacher.fromMap(data.first);
  }

  Future<List<Teacher>> getTeachersByDepartment(String department) async {
    final data = await query('department', department);
    return data.map((e) => Teacher.fromMap(e)).toList();
  }

  Future<Teacher?> getTeacherByEmail(String email) async {
    final data = await query('email', email);
    if (data.isEmpty) return null;
    return Teacher.fromMap(data.first);
  }

  Future<Teacher> createTeacher(Teacher teacher) async {
    final data = await create(teacher.toMap());
    return Teacher.fromMap(data);
  }

  Future<Teacher> updateTeacher(Teacher teacher) async {
    final data = await update(teacher.teacherId, teacher.toMap());
    return Teacher.fromMap(data);
  }

  Future<void> deleteTeacher(String teacherId) async {
    await delete(teacherId);
  }

  Future<bool> isValidTeacherEmail(String email) async {
    final teacher = await getTeacherByEmail(email);
    return teacher != null;
  }

  Future<List<Teacher>> searchTeachers(String searchTerm) async {
    final response = await table.select().or(
      'name.ilike.%$searchTerm%,email.ilike.%$searchTerm%',
    );
    return response.map((e) => Teacher.fromMap(e)).toList();
  }
}

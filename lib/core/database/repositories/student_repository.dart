import '../models/student.dart';
import 'base_repository.dart';

class StudentRepository extends BaseRepository<Student> {
  StudentRepository() : super('student');

  Future<Student?> getStudentById(String id) async {
    final data = await getById(id);
    if (data == null) return null;
    return Student.fromMap(data);
  }

  Future<List<Student>> getAllStudents() async {
    final data = await getAll();
    return data.map((e) => Student.fromMap(e)).toList();
  }

  Future<Student?> getStudentByUserId(String userId) async {
    final data = await query('user_id', userId);
    if (data.isEmpty) return null;
    return Student.fromMap(data.first);
  }

  Future<List<Student>> getStudentsByGroup(String groupName) async {
    final data = await query('group_name', groupName);
    return data.map((e) => Student.fromMap(e)).toList();
  }

  Future<List<Student>> getStudentsByFaculty(String faculty) async {
    final data = await query('faculty', faculty);
    return data.map((e) => Student.fromMap(e)).toList();
  }

  Future<List<Student>> getStudentsBySpecialty(String specialty) async {
    final data = await query('specialty', specialty);
    return data.map((e) => Student.fromMap(e)).toList();
  }

  Future<List<Student>> getStudentsByYear(int year) async {
    final data = await query('year', year);
    return data.map((e) => Student.fromMap(e)).toList();
  }

  Future<Student> createStudent(Student student) async {
    final data = await create(student.toMap());
    return Student.fromMap(data);
  }

  Future<Student> updateStudent(Student student) async {
    final data = await update(student.studentId, student.toMap());
    return Student.fromMap(data);
  }

  Future<void> deleteStudent(String studentId) async {
    await delete(studentId);
  }

  Future<List<Student>> searchStudents(String searchTerm) async {
    final response = await table.select().or(
      'name.ilike.%$searchTerm%,student_id.ilike.%$searchTerm%',
    );
    return response.map((e) => Student.fromMap(e)).toList();
  }

  Future<Map<String, List<Student>>> getStudentsByGroups(
    List<String> groupNames,
  ) async {
    final response = await table.select().inFilter('group_name', groupNames);

    final Map<String, List<Student>> groupedStudents = {};
    for (final data in response) {
      final student = Student.fromMap(data);
      groupedStudents.putIfAbsent(student.groupName, () => []).add(student);
    }
    return groupedStudents;
  }
}

import 'package:flutter/foundation.dart';
import '../../../auth/data/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum UserRole { student, teacher, admin, none }

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider(this._authRepository);

  bool get isAuthenticated => _authRepository.isAuthenticated;
  User? get currentUser => _authRepository.currentUser;

  UserRole _userRole = UserRole.none;
  UserRole get userRole => _userRole;

  Future<void> signIn(String email, String password) async {
    try {
      await _authRepository.signInWithEmail(email: email, password: password);
      await _determineUserRole();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    _userRole = UserRole.none;
    notifyListeners();
  }

  Future<void> _determineUserRole() async {
    final user = currentUser;
    if (user == null) {
      _userRole = UserRole.none;
      return;
    }

    // Get user data from respective tables to determine role
    final client = Supabase.instance.client;

    final studentData =
        await client.from('students').select().eq('user_id', user.id).single();

    if (studentData != null) {
      _userRole = UserRole.student;
      return;
    }

    final teacherData =
        await client.from('teachers').select().eq('user_id', user.id).single();

    if (teacherData != null) {
      _userRole = UserRole.teacher;
      return;
    }

    final adminData =
        await client
            .from('administration')
            .select()
            .eq('user_id', user.id)
            .single();

    if (adminData != null) {
      _userRole = UserRole.admin;
      return;
    }

    _userRole = UserRole.none;
  }
}

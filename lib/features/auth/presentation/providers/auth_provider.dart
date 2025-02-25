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

  Future<void> signUp(
    String email,
    String password,
    UserRole selectedRole,
  ) async {
    try {
      final response = await _authRepository.signUpWithEmail(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final client = Supabase.instance.client;

        // Create entry in role-specific table
        switch (selectedRole) {
          case UserRole.student:
            await client.from('students').insert({
              'user_id': response.user!.id,
            });
            break;
          case UserRole.teacher:
            await client.from('teachers').insert({
              'user_id': response.user!.id,
            });
            break;
          case UserRole.admin:
            await client.from('administration').insert({
              'user_id': response.user!.id,
            });
            break;
          case UserRole.none:
            break;
        }

        _userRole = selectedRole;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

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

    try {
      // Try student
      final studentData =
          await client
              .from('students')
              .select()
              .eq('user_id', user.id)
              .maybeSingle();

      if (studentData != null) {
        _userRole = UserRole.student;
        return;
      }

      // Try teacher
      final teacherData =
          await client
              .from('teachers')
              .select()
              .eq('user_id', user.id)
              .maybeSingle();

      if (teacherData != null) {
        _userRole = UserRole.teacher;
        return;
      }

      // Try admin
      final adminData =
          await client
              .from('administration')
              .select()
              .eq('user_id', user.id)
              .maybeSingle();

      if (adminData != null) {
        _userRole = UserRole.admin;
        return;
      }

      _userRole = UserRole.none;
    } catch (e) {
      _userRole = UserRole.none;
    }
  }
}

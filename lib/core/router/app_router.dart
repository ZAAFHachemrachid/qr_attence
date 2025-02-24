import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/student/presentation/screens/student_home_screen.dart';
import '../../features/teacher/presentation/screens/teacher_home_screen.dart';
import '../../features/admin/presentation/screens/admin_home_screen.dart';

class AppRouter {
  static GoRouter router(BuildContext context) {
    return GoRouter(
      refreshListenable: context.read<AuthProvider>(),
      routes: [
        GoRoute(
          path: '/',
          redirect: (context, state) {
            final authProvider = context.read<AuthProvider>();
            if (!authProvider.isAuthenticated) return '/login';

            switch (authProvider.userRole) {
              case UserRole.student:
                return '/student';
              case UserRole.teacher:
                return '/teacher';
              case UserRole.admin:
                return '/admin';
              default:
                return '/login';
            }
          },
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/student',
          builder: (context, state) => const StudentHomeScreen(),
        ),
        GoRoute(
          path: '/teacher',
          builder: (context, state) => const TeacherHomeScreen(),
        ),
        GoRoute(
          path: '/admin',
          builder: (context, state) => const AdminHomeScreen(),
        ),
      ],
      redirect: (context, state) {
        final authProvider = context.read<AuthProvider>();
        final isAuthenticated = authProvider.isAuthenticated;
        final isLoginRoute = state.matchedLocation == '/login';

        if (!isAuthenticated && !isLoginRoute) {
          return '/login';
        }

        if (isAuthenticated && isLoginRoute) {
          switch (authProvider.userRole) {
            case UserRole.student:
              return '/student';
            case UserRole.teacher:
              return '/teacher';
            case UserRole.admin:
              return '/admin';
            default:
              return '/login';
          }
        }

        return null;
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/ui/screens/chat_screen.dart';
import 'package:etutor/ui/screens/auth/landing_screen.dart';
import 'package:etutor/ui/screens/student_side/show_all_students_screen.dart';
import 'package:etutor/ui/screens/student_side/student_dashboard_screen.dart';
import 'package:etutor/ui/screens/home_screen.dart';
import 'package:etutor/ui/screens/auth/login_screen.dart';
import 'package:etutor/ui/screens/auth/signup_screen.dart';
import 'package:etutor/ui/screens/student_side/student_detail_screen.dart';
import 'package:etutor/ui/screens/teacher_side/show_all_teachers_screen.dart';
import 'package:etutor/ui/screens/teacher_side/teacher_dashboard_screen.dart';
import 'package:etutor/ui/screens/teacher_side/teacher_detail_screen.dart';
import 'package:etutor/ui/screens/teacher_side/teacher_update_profile_screen.dart';
import 'package:flutter/material.dart';

class CustomRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case LoginScreen.routeName:
        final args = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => LoginScreen(userType: args));
      case SignUpScreen.routeName:
        final args = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => SignUpScreen(userType: args));
      case StudentDashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => StudentDashboardScreen());
      case TeacherDashboardScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => const TeacherDashboardScreen());
      case LandingScreen.routeName:
        return MaterialPageRoute(builder: (_) => LandingScreen());

      case ChatScreen.routeName:
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => ChatScreen(
                  chatRoomId: args[0],
                  snapshot: args[1],
                ));

      case ShowAllStudentsScreen.routeName:
        return MaterialPageRoute(builder: (_) => ShowAllStudentsScreen());

      case ShowAllTeachers.routeName:
        return MaterialPageRoute(builder: (_) => const ShowAllTeachers());

      case TeacherUpdateProfileScreen.routeName:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => TeacherUpdateProfileScreen(teacherData: args));

      case TeacherDetailScreen.routeName:
        final args = settings.arguments as DocumentSnapshot;
        return MaterialPageRoute(
            builder: (_) => TeacherDetailScreen(teacherObject: args));

      case StudentDetailScreen.routeName:
        final args = settings.arguments as DocumentSnapshot;
        return MaterialPageRoute(
            builder: (_) => StudentDetailScreen(studentObject: args));

      default:
        return MaterialPageRoute(builder: (_) => LandingScreen());
    }
  }
}

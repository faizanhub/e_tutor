import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/ui/screens/chat_screen.dart';
import 'package:etutor/ui/screens/landing_screen.dart';
import 'package:etutor/ui/screens/show_all_students_screen.dart';
import 'package:etutor/ui/screens/student_dashboard_screen.dart';
import 'package:etutor/ui/screens/home_screen.dart';
import 'package:etutor/ui/screens/login_screen.dart';
import 'package:etutor/ui/screens/signup_screen.dart';
import 'package:etutor/ui/screens/teacher_dashboard_screen.dart';
import 'package:etutor/ui/screens/teacher_detail_screen.dart';
import 'package:etutor/ui/screens/teacher_update_profile_screen.dart';
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
        return MaterialPageRoute(builder: (_) => TeacherDashboardScreen());
      case LandingScreen.routeName:
        return MaterialPageRoute(builder: (_) => LandingScreen());
      case TeacherDetailScreen.routeName:
        final args = settings.arguments as QueryDocumentSnapshot;
        return MaterialPageRoute(
            builder: (_) => TeacherDetailScreen(teacherObject: args));
      case ChatScreen.routeName:
        final args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => ChatScreen(
                  chatRoomId: args[0],
                  chatTitle: args[1],
                ));

      case ShowAllStudentsScreen.routeName:
        return MaterialPageRoute(builder: (_) => ShowAllStudentsScreen());

      case TeacherUpdateProfileScreen.routeName:
        return MaterialPageRoute(builder: (_) => TeacherUpdateProfileScreen());

      default:
        return MaterialPageRoute(builder: (_) => LandingScreen());
    }
  }
}

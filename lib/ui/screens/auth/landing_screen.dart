import 'package:etutor/constants/configs.dart';
import 'package:etutor/core/services/database_service.dart';
import 'package:etutor/ui/screens/home_screen.dart';
import 'package:etutor/ui/screens/student_side/student_dashboard_screen.dart';
import 'package:etutor/ui/screens/teacher_side/teacher_dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  static const routeName = '/';

  DatabaseService _databaseService = DatabaseService();

  Future<String> getUserType(User user) async {
    String type = await _databaseService.getUserType(user);

    return type;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return const HomeScreen();
            } else {
              return FutureBuilder(
                  future: getUserType(user),
                  builder: (context, futureSnapshot) {
                    if (futureSnapshot.hasData) {
                      if (futureSnapshot.data == AppConfigs.studentType) {
                        return StudentDashboardScreen();
                      } else if (futureSnapshot.data ==
                          AppConfigs.teacherType) {
                        return const TeacherDashboardScreen();
                      }
                    }
                    return const Scaffold(
                        body: Center(child: CircularProgressIndicator()));
                  });
            }
          }

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Authenticating User...",
                    textAlign: TextAlign.center,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        });
  }
}

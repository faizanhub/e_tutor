import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/core/services/auth_service.dart';
import 'package:etutor/ui/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentDashboardScreen extends StatefulWidget {
  static const String routeName = '/studentDashboard';

  const StudentDashboardScreen({Key? key}) : super(key: key);

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.studentDashBoard),
      ),
      drawer: Drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Student Dashboard '),
            ElevatedButton(
                onPressed: () async {
                  await _authService.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.routeName, (route) => false);
                },
                child: Text('Sign Out')),
          ],
        ),
      ),
    );
  }
}

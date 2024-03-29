import 'package:etutor/core/utils/my_shared_preferences.dart';
import 'package:etutor/routes.dart';
import 'package:etutor/ui/screens/home_screen.dart';
import 'package:etutor/ui/screens/auth/landing_screen.dart';
import 'package:etutor/ui/screens/auth/login_screen.dart';
import 'package:etutor/ui/screens/auth/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E Tutor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      initialRoute: LandingScreen.routeName,
      onGenerateRoute: CustomRoutes.onGenerateRoute,
    );
  }
}

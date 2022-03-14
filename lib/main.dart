import 'package:etutor/routes.dart';
import 'package:etutor/ui/screens/home_screen.dart';
import 'package:etutor/ui/screens/login_screen.dart';
import 'package:etutor/ui/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
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
          appBarTheme: AppBarTheme(
            centerTitle: true,
          )),
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: CustomRoutes.onGenerateRoute,
    );
  }
}

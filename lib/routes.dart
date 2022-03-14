import 'package:etutor/ui/screens/home_screen.dart';
import 'package:etutor/ui/screens/login_screen.dart';
import 'package:etutor/ui/screens/signup_screen.dart';
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

      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}

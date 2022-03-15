import 'package:etutor/constants/strings/app_strings.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';

  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.dashBoard),
      ),
      drawer: Drawer(),
    );
  }
}

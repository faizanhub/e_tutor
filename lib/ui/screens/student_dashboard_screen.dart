import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/core/services/auth_service.dart';
import 'package:etutor/core/services/database_service.dart';
import 'package:etutor/core/utils/alert_dialog.dart';
import 'package:etutor/core/utils/compare_two_strings.dart';
import 'package:etutor/ui/custom_widgets/custom_drawer.dart';
import 'package:etutor/ui/screens/chat_screen.dart';
import 'package:etutor/ui/screens/home_screen.dart';
import 'package:etutor/ui/screens/teacher_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentDashboardScreen extends StatefulWidget {
  static const String routeName = '/studentDashboard';

  // const StudentDashboardScreen({Key? key}) : super(key: key);

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  AuthService _authService = AuthService();
  DatabaseService _databaseService = DatabaseService();

  List<QueryDocumentSnapshot> teacherNames = [];

  Future<void> signOut() async {
    await _authService.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (route) => false);
  }

  handleListTilePress(int index) async {
    String currentUser = _authService.currentUser!.uid;

    String chatRoomId = getChatRoomId(currentUser, teacherNames[index].id);

    Map<String, dynamic> chatRoomMap = {
      "chatRoomId": chatRoomId,
      "users": [currentUser, teacherNames[index].id]
    };

    //TODO: create chat room collection here, then go to next screen
    await _databaseService.createChatRoom(chatRoomId, chatRoomMap);

    Navigator.pushNamed(context, ChatScreen.routeName, arguments: chatRoomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.studentDashBoard),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
            onPressed: signOut,
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: _databaseService.getTeacherNames(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('some error occurred');
                }

                if (snapshot.hasData && snapshot.data != null) {
                  teacherNames = snapshot.data as List<QueryDocumentSnapshot>;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: teacherNames.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () => handleListTilePress(index),
                            leading: CircleAvatar(
                              child: Text(
                                teacherNames[index]
                                    .get(AppConfigs.fullName)[0]
                                    .toUpperCase(),
                              ),
                            ),
                            title: Text(
                              teacherNames[index].get(AppConfigs.fullName),
                            ),
                            subtitle:
                                Text('${teacherNames[index].get('email')}'),
                            trailing:
                                Text('${teacherNames[index].get('city')}'),
                          );
                        }),
                  );
                }

                return Expanded(child: Center(child: Text('Loading Data...')));
              },
            )
          ],
        ),
      ),
    );
  }
}

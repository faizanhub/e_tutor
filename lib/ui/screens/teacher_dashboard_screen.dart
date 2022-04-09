import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/core/services/auth_service.dart';
import 'package:etutor/core/services/database_service.dart';
import 'package:etutor/core/utils/compare_two_strings.dart';
import 'package:etutor/ui/custom_widgets/custom_drawer.dart';
import 'package:etutor/ui/screens/chat_screen.dart';
import 'package:etutor/ui/screens/home_screen.dart';
import 'package:etutor/ui/screens/show_all_students_screen.dart';
import 'package:etutor/ui/screens/teacher_update_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherDashboardScreen extends StatefulWidget {
  static const routeName = '/teacherDashboard';

  const TeacherDashboardScreen({Key? key}) : super(key: key);

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  List<DocumentSnapshot> allStudentsChatsList = [];

  Future<void> signOut() async {
    await _authService.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (route) => false);
  }

  showAllStudents() {
    Navigator.pushNamed(
      context,
      ShowAllStudentsScreen.routeName,
    );
  }

  Future<String> getUserName() async {
    String userName =
        await _databaseService.getUserName(_authService.currentUser!);
    return userName;
  }

  Future<List<DocumentSnapshot>> getFutureList() async {
    allStudentsChatsList =
        await _databaseService.getAllStudentChats(_authService.currentUser!);

    await Future.delayed(Duration(milliseconds: 900));

    return allStudentsChatsList;
  }

  handleListTilePress(int index, String chatTitle) async {
    String currentUser = _authService.currentUser!.uid;

    String chatRoomId =
        getChatRoomId(currentUser, allStudentsChatsList[index].id);

    Map<String, dynamic> chatRoomMap = {
      "chatRoomId": chatRoomId,
      "users": [currentUser, allStudentsChatsList[index].id]
    };

    //create chat room collection here, then go to next screen
    await _databaseService.createChatRoom(chatRoomId, chatRoomMap);

    Navigator.pushNamed(context, ChatScreen.routeName,
        arguments: [chatRoomId, chatTitle]);
  }

  handleOnSelectedPopUpMenu(value) {
    switch (value) {
      case AppConfigs.showAllStudents:
        showAllStudents();
        break;
      case AppConfigs.logOut:
        signOut();
        break;
      case AppConfigs.updateProfile:
        Navigator.pushNamed(context, TeacherUpdateProfileScreen.routeName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          AppStrings.teacherDashBoard,
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleOnSelectedPopUpMenu,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(AppStrings.showAllStudents),
                value: AppConfigs.showAllStudents,
              ),
              PopupMenuItem(
                child: Text(AppStrings.updateProfile),
                value: AppConfigs.updateProfile,
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                child: Text(AppStrings.logout),
                value: AppConfigs.logOut,
              ),
            ],
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getFutureList(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('some error occurred');
                }

                if (snapshot.hasData && snapshot.data != null) {
                  allStudentsChatsList =
                      snapshot.data as List<DocumentSnapshot>;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: allStudentsChatsList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () => handleListTilePress(
                              index,
                              allStudentsChatsList[index]
                                  .get(AppConfigs.fullName),
                            ),
                            leading: CircleAvatar(
                              child: Text(
                                allStudentsChatsList[index]
                                    .get(AppConfigs.fullName)[0]
                                    .toUpperCase(),
                              ),
                            ),
                            title: Text(
                              allStudentsChatsList[index]
                                  .get(AppConfigs.fullName),
                            ),
                            subtitle: Text(
                                '${allStudentsChatsList[index].get(AppConfigs.email)}'),
                            trailing: Text(
                                '${allStudentsChatsList[index].get(AppConfigs.city)}'),
                          );
                        }),
                  );
                }

                if (snapshot.hasData && snapshot.data == null) {
                  return Expanded(
                      child: Center(child: Text(AppStrings.noChatsDoneYet)));
                }

                return Expanded(
                    child: Center(child: Text(AppStrings.loadingData)));
              },
            )
          ],
        ),
      ),
    );
  }
}

// List<DocumentSnapshot> abc = await _databaseService
//     .getAllStudentChats(_authService.currentUser!);
//
// await Future.delayed(Duration(seconds: 1),
// () => print('******************* ${abc[0]['fullName']}'));

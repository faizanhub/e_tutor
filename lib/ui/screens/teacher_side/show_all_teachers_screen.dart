import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/core/services/auth_service.dart';
import 'package:etutor/core/services/database_service.dart';
import 'package:etutor/core/utils/compare_two_strings.dart';
import 'package:etutor/ui/custom_widgets/custom_drawer.dart';
import 'package:etutor/ui/custom_widgets/custom_teacher_card.dart';
import 'package:etutor/ui/screens/chat_screen.dart';
import 'package:etutor/ui/screens/home_screen.dart';
import 'package:etutor/ui/screens/teacher_side/teacher_detail_screen.dart';

class ShowAllTeachers extends StatefulWidget {
  static const String routeName = '/showAllTeachers';

  const ShowAllTeachers();

  @override
  State<ShowAllTeachers> createState() => _ShowAllTeachersState();
}

class _ShowAllTeachersState extends State<ShowAllTeachers> {
  AuthService _authService = AuthService();
  DatabaseService _databaseService = DatabaseService();

  List<QueryDocumentSnapshot> teacherNames = [];

  bool isLoading = false;

  Future<void> signOut() async {
    await _authService.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (route) => false);
  }

  toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  handleListTilePress(int index, QueryDocumentSnapshot teacherSnapshot) async {
    toggleLoading();
    String currentUserId = _authService.currentUser!.uid;

    String chatRoomId = getChatRoomId(currentUserId, teacherNames[index].id);

    Map<String, dynamic> chatRoomMap = {
      "chatRoomId": chatRoomId,
      "users": [currentUserId, teacherNames[index].id]
    };

    //create chat room collection here, then go to next screen
    await _databaseService.createChatRoom(chatRoomId, chatRoomMap);

    toggleLoading();

    Navigator.pushNamed(context, ChatScreen.routeName,
        arguments: [chatRoomId, teacherSnapshot]);
  }

  Future<String> getUserName() async {
    String userName =
        await _databaseService.getUserName(_authService.currentUser!);
    return userName;
  }

  handleOnSelectedPopUpMenu(value) async {
    switch (value) {
      case AppConfigs.showAllStudents:
        // showAllStudents();
        break;
      case AppConfigs.logOut:
        signOut();
        break;
      // case AppConfigs.updateProfile:
      //   // Navigator.pushNamed(context, TeacherUpdateProfileScreen.routeName,
      //   //     arguments: teacherData);
      //   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.studentDashBoard),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleOnSelectedPopUpMenu,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(AppStrings.showAllTeachers),
                value: AppConfigs.showAllStudents,
              ),
              // PopupMenuItem(
              //   child: Text(AppStrings.updateProfile),
              //   value: AppConfigs.updateProfile,
              // ),
              PopupMenuDivider(),
              PopupMenuItem(
                child: Text(AppStrings.logout),
                value: AppConfigs.logOut,
              ),
            ],
          ),
        ],
      ),
      // drawer: CustomDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'All Teachers',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  FutureBuilder(
                    future: _databaseService.getTeacherNames(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print('some error occurred');
                      }

                      if (snapshot.hasData && snapshot.data != null) {
                        teacherNames =
                            snapshot.data as List<QueryDocumentSnapshot>;
                        return Expanded(
                          child: ListView.builder(
                              itemCount: teacherNames.length,
                              itemBuilder: (context, index) {
                                return CustomTeacherCard(
                                  teacherSnapshot: teacherNames[index],
                                  onButtonPress: () => handleListTilePress(
                                      index, teacherNames[index]),
                                  onCardPress: () {
                                    Navigator.pushNamed(
                                      context,
                                      TeacherDetailScreen.routeName,
                                      arguments: teacherNames[index],
                                    );
                                  },
                                );
                              }),
                        );
                      }

                      return Expanded(
                          child: Center(child: Text('Loading Data...')));
                    },
                  )
                ],
              ),
            ),
    );
  }
}

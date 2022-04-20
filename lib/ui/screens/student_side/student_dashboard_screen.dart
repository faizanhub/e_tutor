import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/core/services/auth_service.dart';
import 'package:etutor/core/services/database_service.dart';
import 'package:etutor/core/utils/alert_dialog.dart';
import 'package:etutor/core/utils/compare_two_strings.dart';
import 'package:etutor/ui/custom_widgets/custom_drawer.dart';
import 'package:etutor/ui/custom_widgets/custom_teacher_card.dart';
import 'package:etutor/ui/screens/chat_screen.dart';
import 'package:etutor/ui/screens/home_screen.dart';
import 'package:etutor/ui/screens/teacher_side/show_all_teachers_screen.dart';
import 'package:etutor/ui/screens/teacher_side/teacher_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentDashboardScreen extends StatefulWidget {
  static const String routeName = '/studentDashboard';

  // const StudentDashboardScreen({Key? key}) : super(key: key);

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List<DocumentSnapshot> allTeachersChatsList = [];

  Map teacherData = {};

  bool isLoading = false;

  Future<void> signOut() async {
    await _authService.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (route) => false);
  }

  showAllTeachers() {
    Navigator.pushNamed(
      context,
      ShowAllTeachers.routeName,
    );
  }

  Future<String> getUserName() async {
    String userName =
        await _databaseService.getUserName(_authService.currentUser!);
    return userName;
  }

  Future<List<DocumentSnapshot>> getFutureList() async {
    allTeachersChatsList =
        await _databaseService.getAllTeacherChats(_authService.currentUser!);

    await Future.delayed(Duration(milliseconds: 900));

    return allTeachersChatsList;
  }

  toggleIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  handleListTilePress(int index, DocumentSnapshot studentSnapshot) async {
    toggleIsLoading();

    String currentUser = _authService.currentUser!.uid;

    String chatRoomId =
        getChatRoomId(currentUser, allTeachersChatsList[index].id);

    Map<String, dynamic> chatRoomMap = {
      "chatRoomId": chatRoomId,
      "users": [currentUser, allTeachersChatsList[index].id]
    };

    //create chat room collection here, then go to next screen
    await _databaseService.createChatRoom(chatRoomId, chatRoomMap);

    toggleIsLoading();
    Navigator.pushNamed(context, ChatScreen.routeName,
        arguments: [chatRoomId, studentSnapshot]);
  }

  handleOnSelectedPopUpMenu(value) async {
    switch (value) {
      case AppConfigs.showAllTeachers:
        showAllTeachers();
        break;
      case AppConfigs.logOut:
        signOut();
        break;
      // case AppConfigs.updateProfile:
      //   Navigator.pushNamed(context, TeacherUpdateProfileScreen.routeName,
      //       arguments: teacherData);
      //   break;
    }
  }

  getTeacherData() async {
    try {
      teacherData =
          await _databaseService.getTeacherData(_firebaseAuth.currentUser!);
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  void initState() {
    getTeacherData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          AppStrings.studentDashBoard,
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleOnSelectedPopUpMenu,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(AppStrings.showAllTeachers),
                value: AppConfigs.showAllTeachers,
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
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
                        allTeachersChatsList =
                            snapshot.data as List<DocumentSnapshot>;
                        return Expanded(
                          child: ListView.builder(
                              itemCount: allTeachersChatsList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () => handleListTilePress(
                                    index,
                                    allTeachersChatsList[index],
                                  ),
                                  leading: CircleAvatar(
                                    child: Text(
                                      allTeachersChatsList[index]
                                          .get(AppConfigs.fullName)[0]
                                          .toUpperCase(),
                                    ),
                                  ),
                                  title: Text(
                                    allTeachersChatsList[index]
                                        .get(AppConfigs.fullName),
                                  ),
                                  subtitle: Text(
                                      '${allTeachersChatsList[index].get(AppConfigs.email)}'),
                                  trailing: Text(
                                      '${allTeachersChatsList[index].get(AppConfigs.city)}'),
                                );
                              }),
                        );
                      }

                      if (snapshot.hasData && snapshot.data == null) {
                        return Expanded(
                            child:
                                Center(child: Text(AppStrings.noChatsDoneYet)));
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

/*                                ListTile(
                                  onTap: () => handleListTilePress(
                                      index, teacherNames[index]),
                                  leading: CircleAvatar(
                                    child: Text(
                                      teacherNames[index]
                                          .get(AppConfigs.fullName)[0]
                                          .toUpperCase(),
                                    ),
                                  ),
                                  title: Text(
                                    teacherNames[index]
                                        .get(AppConfigs.fullName),
                                  ),
                                  subtitle: Text(
                                      '${teacherNames[index].get('email')}'),
                                  trailing: Text(
                                      '${teacherNames[index].get('city')}'),
                                );

 */

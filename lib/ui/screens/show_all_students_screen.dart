import 'package:etutor/constants/strings/error_strings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/core/services/auth_service.dart';
import 'package:etutor/core/services/database_service.dart';
import 'package:etutor/core/utils/compare_two_strings.dart';
import 'package:etutor/ui/custom_widgets/custom_drawer.dart';
import 'package:etutor/ui/screens/chat_screen.dart';
import 'package:etutor/ui/screens/home_screen.dart';

class ShowAllStudentsScreen extends StatefulWidget {
  static const String routeName = '/showAllStudents';

  @override
  State<ShowAllStudentsScreen> createState() => _ShowAllStudentsScreenState();
}

class _ShowAllStudentsScreenState extends State<ShowAllStudentsScreen> {
  AuthService _authService = AuthService();
  DatabaseService _databaseService = DatabaseService();

  List<QueryDocumentSnapshot> studentNames = [];

  Future<void> signOut() async {
    await _authService.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (route) => false);
  }

  handleListTilePress(int index, String chatTitle) async {
    String currentUser = _authService.currentUser!.uid;

    String chatRoomId = getChatRoomId(currentUser, studentNames[index].id);

    Map<String, dynamic> chatRoomMap = {
      "chatRoomId": chatRoomId,
      "users": [currentUser, studentNames[index].id]
    };

    //create chat room collection here, then go to next screen
    await _databaseService.createChatRoom(chatRoomId, chatRoomMap);

    Navigator.pushNamed(context, ChatScreen.routeName,
        arguments: [chatRoomId, chatTitle]);
  }

  Future<String> getUserName() async {
    String userName =
        await _databaseService.getUserName(_authService.currentUser!);
    return userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.allStudents),
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
      // drawer: CustomDrawer(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: _databaseService.getStudentNames(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(ErrorStrings.someErrorOccurred);
                }

                if (snapshot.hasData && snapshot.data != null) {
                  studentNames = snapshot.data as List<QueryDocumentSnapshot>;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: studentNames.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () => handleListTilePress(index,
                                studentNames[index].get(AppConfigs.fullName)),
                            leading: CircleAvatar(
                              child: Text(
                                studentNames[index]
                                    .get(AppConfigs.fullName)[0]
                                    .toUpperCase(),
                              ),
                            ),
                            title: Text(
                              studentNames[index].get(AppConfigs.fullName),
                            ),
                            subtitle: Text(
                                '${studentNames[index].get(AppConfigs.email)}'),
                            trailing: Text(
                                '${studentNames[index].get(AppConfigs.city)}'),
                          );
                        }),
                  );
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

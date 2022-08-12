import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/strings/error_strings.dart';
import 'package:etutor/core/services/auth_service.dart';
import 'package:etutor/core/services/database_service.dart';
import 'package:etutor/core/utils/alert_dialog.dart';
import 'package:etutor/ui/custom_widgets/custom_textfield.dart';
import 'package:etutor/ui/custom_widgets/messages_stream.dart';
import 'package:etutor/ui/screens/student_side/student_detail_screen.dart';
import 'package:etutor/ui/screens/teacher_side/teacher_detail_screen.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chatScreen';

  final String chatRoomId;
  final DocumentSnapshot snapshot;

  const ChatScreen({
    Key? key,
    required this.chatRoomId,
    required this.snapshot,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  TextEditingController messageC = TextEditingController();

  bool isLoading = false;

  toggleIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  handleSendMessage() async {
    if (messageC.text.isNotEmpty) {
      toggleIsLoading();
      String currentUserId = _authService.currentUser!.uid;
      String userName =
          await _databaseService.getUserName(_authService.currentUser!);

      Map<String, dynamic> messageMap = {
        'sender_id': currentUserId,
        'sender_name': userName,
        'text': messageC.text,
        'time': DateTime.now(),
      };

      messageC.clear();

      await _databaseService.addConversationMessages(
          widget.chatRoomId, messageMap);

      toggleIsLoading();
    } else {
      showAlertDialog(
          context, ErrorStrings.error, ErrorStrings.messageShouldNotBeEmpty);
    }
  }

  handleAppBarClick() {
    if (widget.snapshot[AppConfigs.userType] == AppConfigs.teacherType) {
      Navigator.pushNamed(context, TeacherDetailScreen.routeName,
          arguments: widget.snapshot);
    } else if (widget.snapshot[AppConfigs.userType] == AppConfigs.studentType) {
      Navigator.pushNamed(context, StudentDetailScreen.routeName,
          arguments: widget.snapshot);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: GestureDetector(
            onTap: handleAppBarClick,
            child: Text(widget.snapshot.get(AppConfigs.fullName))),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ///Messages Area
          MessagesStream(chatRoomId: widget.chatRoomId),

          ///TextBox AreaS
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: messageC,
                    hintText: 'Enter your message',
                    minLines: 1,
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: IconButton(
                    onPressed: handleSendMessage,
                    icon: Icon(
                      Icons.send,
                      size: 40,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

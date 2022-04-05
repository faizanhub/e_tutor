import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/strings/error_strings.dart';
import 'package:etutor/core/services/auth_service.dart';
import 'package:etutor/core/services/database_service.dart';
import 'package:etutor/core/utils/alert_dialog.dart';
import 'package:etutor/ui/custom_widgets/custom_textfield.dart';
import 'package:etutor/ui/custom_widgets/messages_stream.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chatScreen';

  final String chatRoomId;
  final String chatTitle;

  ChatScreen({
    required this.chatRoomId,
    required this.chatTitle,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  AuthService _authService = AuthService();
  DatabaseService _databaseService = DatabaseService();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ///Messages Area
          MessagesStream(chatRoomId: widget.chatRoomId),

          ///TextBox Area
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: messageC,
                    hintText: 'Enter your message',
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
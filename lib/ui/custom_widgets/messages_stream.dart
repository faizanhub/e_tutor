import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/strings/error_strings.dart';
import 'package:etutor/core/services/database_service.dart';
import 'package:etutor/core/utils/alert_dialog.dart';
import 'package:flutter/material.dart';

class MessagesStream extends StatelessWidget {
  final String chatRoomId;
  DatabaseService _databaseService = DatabaseService();

  MessagesStream({
    required this.chatRoomId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _databaseService.getConversationMessages(chatRoomId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            showAlertDialog(
                context, ErrorStrings.error, ErrorStrings.dataLoadError);
          } else if (!snapshot.hasData) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.noMessages),
                ],
              ),
            );
          }

          //Now the data is received

          List<QueryDocumentSnapshot> messages = snapshot.data!.docs;

          return Expanded(
            child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(child: Text("A")),
                      title: Text(messages[index].get(AppConfigs.text)),
                      subtitle: Text(messages[index]
                          .get(AppConfigs.time)
                          .toDate()
                          .toString()),
                    ),
                  );
                }),
          );
        });
  }
}

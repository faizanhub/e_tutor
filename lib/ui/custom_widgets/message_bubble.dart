import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:flutter/material.dart';
import 'package:etutor/constants/text_styles.dart';

class MessageBubble extends StatelessWidget {
  final List<QueryDocumentSnapshot> messages;
  final String senderName;
  final int index;
  final bool isSendByMe;

  MessageBubble({
    required this.messages,
    required this.senderName,
    required this.index,
    required this.isSendByMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 1.2,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        decoration: BoxDecoration(
            // color: Colors.blue,
            gradient: LinearGradient(
              colors: isSendByMe
                  ? [
                      Colors.purple,
                      Colors.deepPurple,
                    ]
                  : [
                      const Color(0xFF2e2e2e),
                      const Color(0xFF2e2e2e),
                    ],
            ),
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23),
                  )),
        child: Column(
          children: [
            Text(
              messages[index].get(AppConfigs.text),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

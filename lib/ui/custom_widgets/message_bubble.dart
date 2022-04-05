import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:flutter/material.dart';
import 'package:etutor/constants/text_styles.dart';
import 'package:intl/intl.dart';

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
    print('**********' + isSendByMe.toString());
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
          crossAxisAlignment:
              isSendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              messages[index].get(AppConfigs.text),
              style: messageBubbleTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              DateFormat("hh:mm a")
                  .format(messages[index].get(AppConfigs.time).toDate()),
              style: messageBubbleTextStyle.copyWith(color: Colors.grey),
            ),
            // Text(
            //   DateFormat("dd-MM-y")
            //       .format(messages[index].get(AppConfigs.time).toDate()),
            //   style: messageBubbleTextStyle.copyWith(color: Colors.grey),
            // ),
          ],
        ),
      ),
    );
  }
}

// Widget build(BuildContext context) {
//   return Card(
//     child: ListTile(
//       leading: Column(
//         children: [
//           CircleAvatar(
//             child: Text(
//               senderName[0],
//             ),
//           ),
//           SizedBox(height: 2),
//           Text('$senderName', style: chatTextName),
//         ],
//       ),
//       title: Text(messages[index].get(AppConfigs.text)),
//       subtitle:
//       Text(messages[index].get(AppConfigs.time).toDate().toString()),
//     ),
//   );
// }
// messages[index].get(AppConfigs.time).toDate().toString()

// DateFormat.yMMMd()
// .add_jms()
//     .format(messages[index].get(AppConfigs.time).toDate()),

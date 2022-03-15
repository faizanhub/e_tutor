import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String title, desc) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(desc),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok')),
          ],
        );
      });
}

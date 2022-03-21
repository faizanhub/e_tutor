import 'package:etutor/constants/strings/app_strings.dart';
import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

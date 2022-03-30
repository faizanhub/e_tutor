import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/strings/app_strings.dart';
import 'package:flutter/material.dart';

class TeacherDetailScreen extends StatelessWidget {
  static const String routeName = '/teacherDetailScreen';

  QueryDocumentSnapshot teacherObject;

  TeacherDetailScreen({
    required this.teacherObject,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.teacherDetails),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('${teacherObject.get('fullName')}'),
          Text('${teacherObject.get('city')}'),
          Text('${teacherObject.get('email')}'),
        ],
      ),
    );
  }
}

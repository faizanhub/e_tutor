import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/text_styles.dart';
import 'package:etutor/core/utils/validators.dart';
import 'package:etutor/ui/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class TeacherDetailScreen extends StatelessWidget {
  static const String routeName = '/teacherDetailScreen';

  DocumentSnapshot teacherObject;

  TeacherDetailScreen({
    required this.teacherObject,
  });

  @override
  Widget build(BuildContext context) {
    var teacherData = teacherObject.data().toString();

    // print(teacherData.contains('subjects'));

    TextEditingController fullNameC =
        TextEditingController(text: teacherObject[AppConfigs.fullName]);

    TextEditingController cityC =
        TextEditingController(text: teacherObject[AppConfigs.city]);
    TextEditingController addressC =
        TextEditingController(text: teacherObject[AppConfigs.address]);

    TextEditingController emailC =
        TextEditingController(text: teacherObject[AppConfigs.email]);

    TextEditingController subjectsC = TextEditingController(
        text: teacherData.contains(AppConfigs.subjects)
            ? teacherObject.get(AppConfigs.subjects)
            : '');
    TextEditingController experienceC = TextEditingController(
        text: teacherData.contains(AppConfigs.experience)
            ? teacherObject.get(AppConfigs.experience)
            : '');

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.profile),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///TextFields
                Column(
                  children: [
                    CustomTextField(
                      hintText: AppStrings.fullName,
                      labelText: AppStrings.fullName,
                      prefixIcon: Icons.person_outlined,
                      controller: fullNameC,
                      validator: validateFullNameField,
                      readOnly: true,
                      enabled: false,
                    ),
                    SizedBox(height: 4),
                    CustomTextField(
                      hintText: AppStrings.email,
                      labelText: AppStrings.email,
                      prefixIcon: Icons.email,
                      controller: emailC,
                      validator: validateFullNameField,
                      readOnly: true,
                      enabled: false,
                    ),
                    SizedBox(height: 4),
                    CustomTextField(
                      hintText: AppStrings.city,
                      labelText: AppStrings.city,
                      prefixIcon: Icons.place_outlined,
                      controller: cityC,
                      validator: validateCityField,
                      readOnly: true,
                      enabled: false,
                    ),
                    SizedBox(height: 4),
                    CustomTextField(
                      hintText: AppStrings.address,
                      labelText: AppStrings.address,
                      prefixIcon: Icons.home_outlined,
                      controller: addressC,
                      validator: validateCityField,
                      readOnly: true,
                      enabled: false,
                    ),
                    SizedBox(height: 4),
                    CustomTextField(
                      hintText: AppStrings.subjects,
                      labelText: AppStrings.subjects,
                      minLines: 1,
                      maxLines: 4,
                      prefixIcon: Icons.subject_outlined,
                      controller: subjectsC,
                      readOnly: true,
                      enabled: false,
                    ),
                    SizedBox(height: 4),
                    CustomTextField(
                      hintText: AppStrings.experience,
                      labelText: AppStrings.experience,
                      prefixIcon: Icons.task_outlined,
                      controller: experienceC,
                      readOnly: true,
                      enabled: false,
                    ),
                  ],
                ),

                SizedBox(height: 20),

                ///Create Account Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(double.infinity, 45),
                    ),
                  ),
                  child: Text(
                    AppStrings.back,
                    style: buttonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

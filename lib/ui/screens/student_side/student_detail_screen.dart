import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/text_styles.dart';
import 'package:etutor/core/utils/validators.dart';
import 'package:etutor/ui/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class StudentDetailScreen extends StatelessWidget {
  static const String routeName = '/studentDetailScreen';

  DocumentSnapshot studentObject;

  StudentDetailScreen({
    required this.studentObject,
  });

  @override
  Widget build(BuildContext context) {
    var studentData = studentObject.data().toString();

    // print(teacherData.contains('subjects'));

    TextEditingController fullNameC =
        TextEditingController(text: studentObject[AppConfigs.fullName]);

    TextEditingController emailC =
        TextEditingController(text: studentObject[AppConfigs.email]);

    TextEditingController cityC =
        TextEditingController(text: studentObject[AppConfigs.city]);
    TextEditingController addressC =
        TextEditingController(text: studentObject[AppConfigs.address]);

    TextEditingController subjectsC = TextEditingController(
        text: studentData.contains(AppConfigs.subjects)
            ? studentObject.get(AppConfigs.subjects)
            : '');
    TextEditingController experienceC = TextEditingController(
        text: studentData.contains(AppConfigs.experience)
            ? studentObject.get(AppConfigs.experience)
            : '');

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profile),
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
                      readOnly: true,
                      enabled: false,
                    ),
                    const SizedBox(height: 4),
                    CustomTextField(
                      hintText: AppStrings.email,
                      labelText: AppStrings.email,
                      prefixIcon: Icons.email,
                      controller: emailC,
                      readOnly: true,
                      enabled: false,
                    ),
                    const SizedBox(height: 4),
                    CustomTextField(
                      hintText: AppStrings.city,
                      labelText: AppStrings.city,
                      prefixIcon: Icons.place_outlined,
                      controller: cityC,
                      readOnly: true,
                      enabled: false,
                    ),
                    const SizedBox(height: 4),
                    CustomTextField(
                      hintText: AppStrings.address,
                      labelText: AppStrings.address,
                      prefixIcon: Icons.home_outlined,
                      controller: addressC,
                      readOnly: true,
                      enabled: false,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                ///Create Account Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 45),
                    ),
                  ),
                  child: const Text(
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

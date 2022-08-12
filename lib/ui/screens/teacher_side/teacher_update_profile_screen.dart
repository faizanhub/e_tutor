import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/text_styles.dart';
import 'package:etutor/core/models/updateTeacher.dart';
import 'package:etutor/core/services/database_service.dart';
import 'package:etutor/core/utils/snack_bar.dart';
import 'package:etutor/core/utils/validators.dart';
import 'package:etutor/ui/custom_widgets/custom_textfield.dart';
import 'package:etutor/ui/screens/teacher_side/teacher_dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherUpdateProfileScreen extends StatefulWidget {
  static const String routeName = '/teacherUpdateProfile';

  final Map teacherData;

  const TeacherUpdateProfileScreen({required this.teacherData});

  @override
  State<TeacherUpdateProfileScreen> createState() =>
      _TeacherUpdateProfileScreenState();
}

class _TeacherUpdateProfileScreenState
    extends State<TeacherUpdateProfileScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final UpdateTeacher _updateTeacher = UpdateTeacher();

  bool isLoading = false;

  toggleIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    TextEditingController fullNameC =
        TextEditingController(text: widget.teacherData[AppConfigs.fullName]);

    TextEditingController cityC =
        TextEditingController(text: widget.teacherData[AppConfigs.city]);
    TextEditingController addressC =
        TextEditingController(text: widget.teacherData[AppConfigs.address]);
    TextEditingController subjectsC = TextEditingController(
        text: widget.teacherData[AppConfigs.subjects] ?? '');
    TextEditingController experienceC = TextEditingController(
        text: widget.teacherData[AppConfigs.experience] ?? '');

    handleUpdateProfile() async {
      if (_formKey.currentState!.validate()) {
        _updateTeacher.fullName = fullNameC.text;

        _updateTeacher.city = cityC.text;
        _updateTeacher.address = addressC.text;
        _updateTeacher.subjects = subjectsC.text;
        _updateTeacher.experience = experienceC.text;

        //TODO: update data of teacher in users collection
        toggleIsLoading(true);
        await _databaseService.updateTeacherData(
            _updateTeacher, _firebaseAuth.currentUser!.uid);

        toggleIsLoading(false);

        Navigator.pushNamed(context, TeacherDashboardScreen.routeName);

        showSnackBar(context, 'Data updated successfully');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.updateProfile),
      ),
      body: isLoading
          ? const Center(
              child: const CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(14.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///TextFields
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: AppStrings.fullName,
                              labelText: AppStrings.fullName,
                              prefixIcon: Icons.person_outlined,
                              controller: fullNameC,
                              validator: validateFullNameField,
                            ),
                            const SizedBox(height: 4),
                            CustomTextField(
                              hintText: AppStrings.city,
                              labelText: AppStrings.city,
                              prefixIcon: Icons.place_outlined,
                              controller: cityC,
                              validator: validateCityField,
                            ),
                            const SizedBox(height: 4),
                            CustomTextField(
                              hintText: AppStrings.address,
                              labelText: AppStrings.address,
                              prefixIcon: Icons.home_outlined,
                              controller: addressC,
                              validator: validateCityField,
                            ),
                            const SizedBox(height: 4),
                            CustomTextField(
                              hintText: AppStrings.subjects,
                              labelText: AppStrings.subjects,
                              minLines: 1,
                              maxLines: 4,
                              prefixIcon: Icons.subject_outlined,
                              controller: subjectsC,
                            ),
                            const SizedBox(height: 4),
                            CustomTextField(
                              hintText: AppStrings.experience,
                              labelText: AppStrings.experience,
                              prefixIcon: Icons.task_outlined,
                              controller: experienceC,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      ///Create Account Button
                      ElevatedButton(
                        onPressed: handleUpdateProfile,
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 45),
                          ),
                        ),
                        child: const Text(
                          AppStrings.update,
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

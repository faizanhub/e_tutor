import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/text_styles.dart';
import 'package:etutor/ui/custom_widgets/custom_button.dart';
import 'package:etutor/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    void handleTeacherButton() {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName,
          arguments: AppConfigs.teacherType);
    }

    void handleStudentButton() {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName,
          arguments: AppConfigs.studentType);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// icon/image logo of home screen
            Image.asset(
              AppStrings.homeScreen_image,
              height: 280,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Column(
              children: [
                ///text
                Text(
                  AppStrings.user_type,
                  style: userTypeTextStyle,
                ),

                SizedBox(height: 45),

                ///Teacher Button
                CustomButton(
                  onPressed: handleTeacherButton,
                  title: AppStrings.teacher,
                ),

                SizedBox(height: 30),

                ///Student Button
                CustomButton(
                  onPressed: handleStudentButton,
                  title: AppStrings.student,
                ),
              ],
            ),

            SizedBox(),
          ],
        ),
      ),
    );
  }
}

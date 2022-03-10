import 'package:etutor/constants/app_strings.dart';
import 'package:etutor/constants/text_styles.dart';
import 'package:etutor/ui/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

                SizedBox(height: 40),

                ///Teacher Button
                CustomButton(
                  onPressed: () {},
                  title: AppStrings.teacher,
                ),

                SizedBox(height: 30),

                ///Student Button
                CustomButton(
                  onPressed: () {},
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

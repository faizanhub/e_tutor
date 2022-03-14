import 'package:etutor/constants/app_strings.dart';
import 'package:etutor/constants/text_styles.dart';
import 'package:etutor/ui/custom_widgets/custom_textfield.dart';
import 'package:etutor/ui/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  String userType;

  LoginScreen({
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    print(userType);

    goToSignUp() {
      Navigator.pushNamed(context, SignUpScreen.routeName, arguments: userType);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.loginAccount),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///TextFields

            CustomTextField(
              hintText: AppStrings.email,
              prefixIcon: Icons.email,
            ),

            CustomTextField(
              hintText: AppStrings.password,
              prefixIcon: Icons.lock_outlined,
              obsecureText: true,
            ),

            SizedBox(height: 20),

            ///Button
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  Size(double.infinity, 45),
                ),
              ),
              child: Text(
                AppStrings.loginAccount,
                style: buttonTextStyle,
              ),
            ),

            SizedBox(height: 20),

            ///Already have an account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.dontHaveAccount,
                  style: alreadyhaveAccountStyle,
                ),
                GestureDetector(
                  onTap: goToSignUp,
                  child: Text(
                    AppStrings.createNow,
                    style: loginNowTextStyle,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

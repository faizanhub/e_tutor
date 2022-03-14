import 'package:etutor/constants/app_strings.dart';
import 'package:etutor/constants/text_styles.dart';
import 'package:etutor/ui/custom_widgets/custom_button.dart';
import 'package:etutor/ui/custom_widgets/custom_textfield.dart';
import 'package:etutor/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/signup';

  String userType;

  SignUpScreen({
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    print('Sign Up Screen ' + userType);

    goToLoginScreen() {
      Navigator.pushNamed(context, LoginScreen.routeName, arguments: userType);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.createAccount),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///TextFields
                CustomTextField(
                  hintText: AppStrings.name,
                  prefixIcon: Icons.person_outlined,
                ),

                CustomTextField(
                  hintText: AppStrings.city,
                  prefixIcon: Icons.place_outlined,
                ),

                CustomTextField(
                  hintText: AppStrings.email,
                  prefixIcon: Icons.email,
                ),

                CustomTextField(
                  hintText: AppStrings.password,
                  prefixIcon: Icons.lock_outlined,
                  obsecureText: true,
                ),

                CustomTextField(
                  hintText: AppStrings.confirmPassword,
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
                    AppStrings.createAccount,
                    style: buttonTextStyle,
                  ),
                ),

                SizedBox(height: 20),

                ///Already have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.alreadyHaveAccount,
                      style: alreadyhaveAccountStyle,
                    ),
                    GestureDetector(
                      onTap: goToLoginScreen,
                      child: Text(
                        AppStrings.loginNow,
                        style: loginNowTextStyle,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

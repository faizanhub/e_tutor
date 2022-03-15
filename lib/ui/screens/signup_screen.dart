import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/text_styles.dart';
import 'package:etutor/core/services/auth_service.dart';
import 'package:etutor/core/utils/alert_dialog.dart';
import 'package:etutor/ui/custom_widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';

  String userType;

  SignUpScreen({
    required this.userType,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  final authService = AuthService();

  bool isLoading = false;

  toggleIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Sign Up Screen ' + widget.userType);

    void goToLoginScreen() {
      Navigator.pop(context);
    }

    void handleCreateAccountBtn() async {
      toggleIsLoading(true);
      AuthResponse response =
          await authService.createAccount(emailC.text, passwordC.text);

      toggleIsLoading(false);

      if (response.status) {
        ///Account Creation Successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.accountCreatedSuccessfully),
          ),
        );
        Navigator.pop(context);

        print('Account Creation Ok');
      } else {
        ///Show Alert
        showAlertDialog(context, AppStrings.failed, response.message);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.createAccount),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
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
                        controller: emailC,
                      ),

                      CustomTextField(
                        hintText: AppStrings.password,
                        prefixIcon: Icons.lock_outlined,
                        obsecureText: true,
                        controller: passwordC,
                      ),

                      CustomTextField(
                        hintText: AppStrings.confirmPassword,
                        prefixIcon: Icons.lock_outlined,
                        obsecureText: true,
                      ),

                      SizedBox(height: 20),

                      ///Create Account Button
                      ElevatedButton(
                        onPressed: handleCreateAccountBtn,
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

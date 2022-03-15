import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/text_styles.dart';
import 'package:etutor/core/services/auth_service.dart';
import 'package:etutor/core/utils/alert_dialog.dart';
import 'package:etutor/core/utils/validators.dart';
import 'package:etutor/ui/custom_widgets/custom_textfield.dart';
import 'package:etutor/ui/screens/dashboard_screen.dart';
import 'package:etutor/ui/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  String userType;

  LoginScreen({
    required this.userType,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final authService = AuthService();
  bool isLoading = false;

  toggleIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  void goToSignUp() {
    Navigator.pushNamed(context, SignUpScreen.routeName,
            arguments: widget.userType)
        .then((value) {
      emailController.clear();
      passwordController.clear();
    });
  }

  void goToDashboard() {
    Navigator.pushReplacementNamed(context, DashBoardScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userType);

    void handleLoginButton() async {
      if (_formKey.currentState!.validate()) {
        toggleIsLoading(true);
        AuthResponse? response = await authService.login(
            emailController.text, passwordController.text);

        toggleIsLoading(false);

        if (response.status) {
          ///Login Successful
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppStrings.loginSuccessful),
            ),
          );

          goToDashboard();
        } else {
          showAlertDialog(context, AppStrings.failed, response.message);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.loginAccount),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///TextFields

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: AppStrings.email,
                          prefixIcon: Icons.email,
                          controller: emailController,
                          validator: validateEmailField,
                        ),
                        CustomTextField(
                          hintText: AppStrings.password,
                          prefixIcon: Icons.lock_outlined,
                          obsecureText: true,
                          controller: passwordController,
                          validator: validatePasswordField,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  ///Login Button
                  ElevatedButton(
                    onPressed: handleLoginButton,
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

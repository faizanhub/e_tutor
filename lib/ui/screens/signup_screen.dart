import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/text_styles.dart';
import 'package:etutor/core/models/person.dart';
import 'package:etutor/core/services/auth_service.dart';
import 'package:etutor/core/utils/alert_dialog.dart';
import 'package:etutor/core/utils/validators.dart';
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
  TextEditingController fullNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Person person = Person();

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
      if (_formKey.currentState!.validate()) {
        if (passwordC.text == confirmPasswordC.text) {
          person.fullName = fullNameC.text;
          person.email = emailC.text;
          person.password = passwordC.text;
          person.city = cityC.text;
          person.address = addressC.text;
          person.userType = widget.userType;

          toggleIsLoading(true);
          AuthResponse response = await authService.createAccount(person);

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
        } else {
          showAlertDialog(
              context, AppStrings.failed, AppStrings.passwordFieldsNotSame);
        }
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
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              hintText: AppStrings.fullName,
                              prefixIcon: Icons.person_outlined,
                              controller: fullNameC,
                              validator: validateFullNameField,
                            ),
                            CustomTextField(
                              hintText: AppStrings.email,
                              prefixIcon: Icons.email,
                              controller: emailC,
                              validator: validateEmailField,
                            ),
                            CustomTextField(
                              hintText: AppStrings.city,
                              prefixIcon: Icons.place_outlined,
                              controller: cityC,
                              validator: validateCityField,
                            ),
                            CustomTextField(
                              hintText: AppStrings.address,
                              prefixIcon: Icons.home_outlined,
                              controller: addressC,
                              validator: validateCityField,
                            ),
                            CustomTextField(
                              hintText: AppStrings.password,
                              prefixIcon: Icons.lock_outlined,
                              obsecureText: true,
                              controller: passwordC,
                              validator: validatePasswordField,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                            CustomTextField(
                              hintText: AppStrings.confirmPassword,
                              prefixIcon: Icons.lock_outlined,
                              obsecureText: true,
                              controller: confirmPasswordC,
                              validator: validatePasswordField,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ],
                        ),
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

import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/text_styles.dart';
import 'package:etutor/core/utils/validators.dart';
import 'package:etutor/ui/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class TeacherUpdateProfileScreen extends StatefulWidget {
  static const String routeName = '/teacherUpdateProfile';

  const TeacherUpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<TeacherUpdateProfileScreen> createState() =>
      _TeacherUpdateProfileScreenState();
}

class _TeacherUpdateProfileScreenState
    extends State<TeacherUpdateProfileScreen> {
  TextEditingController fullNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.updateProfile),
      ),
      body: Padding(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

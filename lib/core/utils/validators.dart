import 'package:etutor/constants/strings/app_strings.dart';
import 'package:flutter/material.dart';

String? validateEmailField(String? email) {
  if (email == null || email.isEmpty || !email.contains('@')) {
    return AppStrings.enterValidEmail;
  }
  return null;
}

String? validatePasswordField(String? password) {
  if (password == null || password.isEmpty || password.length < 6) {
    return AppStrings.enterValidPassword;
  }
  return null;
}

String? validateFullNameField(String? fullName) {
  if (fullName == null || fullName.isEmpty) {
    return AppStrings.fullNameIsRequired;
  }
  return null;
}

String? validateCityField(String? city) {
  if (city == null || city.isEmpty) {
    return AppStrings.cityIsRequired;
  }
  return null;
}

String? validateAddressField(String? city) {
  if (city == null || city.isEmpty) {
    return AppStrings.addressIsRequired;
  }
  return null;
}

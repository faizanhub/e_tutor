import 'package:etutor/constants/strings/app_strings.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final bool obsecureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? labelText;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final bool? enabled;

  CustomTextField({
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.obsecureText = false,
    this.validator,
    this.keyboardType,
    this.labelText,
    this.minLines,
    this.maxLines,
    this.readOnly = false,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        readOnly: readOnly,
        obscureText: obsecureText,
        validator: validator,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

import 'package:etutor/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Color backgroundColor;

  CustomButton({
    required this.onPressed,
    required this.title,
    this.backgroundColor = Colors.purple,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          Size(240, 45),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
      onPressed: () {},
      child: Text(title, style: buttonTextStyle),
    );
  }
}

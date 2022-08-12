import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/text_styles.dart';
import 'package:etutor/ui/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CustomTeacherCard extends StatelessWidget {
  final QueryDocumentSnapshot teacherSnapshot;
  final VoidCallback onCardPress;
  final VoidCallback? onCardLongPress;
  final VoidCallback? onButtonPress;

  const CustomTeacherCard({
    required this.teacherSnapshot,
    required this.onCardPress,
    this.onCardLongPress,
    this.onButtonPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardPress,
      onLongPress: onCardLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: SizedBox(
          height: 100,
          child: Card(
            elevation: 3,
            color: const Color(0xfff2f2f8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(teacherSnapshot.get(AppConfigs.fullName),
                      style: titleTextStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            teacherSnapshot.get(AppConfigs.email),
                            style: descTextStyle,
                          ),
                          Text(
                            teacherSnapshot.get(AppConfigs.city),
                            style: cityTextStyle,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 80,
                        child: ElevatedButton(
                          onPressed: onButtonPress,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.purple.shade400),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          child: const Text(AppStrings.chat),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

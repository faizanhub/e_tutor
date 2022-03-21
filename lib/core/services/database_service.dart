import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/core/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveAccountData(Person person, String uid) async {
    try {
      await _firestore
          .collection(AppConfigs.usersCollection)
          .doc(uid)
          .set(person.toJson());
    } catch (e) {
      print(
          'Exception occurred while saving data to firestore ${e.toString()}');
    }
  }

  Future<String> getUserType(User user) async {
    final DocumentSnapshot snapshot = await _firestore
        .collection(AppConfigs.usersCollection)
        .doc(user.uid)
        .get();

    Map data = snapshot.data() as Map;

    return data[AppConfigs.userType];
  }

  // Future<List> getTeacherNames() async {
  //   List myData = [];
  //   try {
  //     final QuerySnapshot snapshot = await _firestore
  //         .collection(AppConfigs.usersCollection)
  //         .get();
  //
  //
  //
  //    for(var i in snapshot.docs) {
  //      print(i.data());
  //      myData.add();
  //    }
  //
  //
  //   } catch (e) {
  //     print(
  //         'Error occurred while fetching data from firestore ${e.toString()}');
  //   }
  // }

}

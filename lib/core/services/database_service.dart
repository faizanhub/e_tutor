import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/constants/strings/error_strings.dart';
import 'package:etutor/core/models/person.dart';
import 'package:etutor/core/models/updateTeacher.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DBBase {
  Future<void> saveAccountData(Person person, String uid);
  Future<String> getUserType(User user);
  Future<String> getUserName(User user);
  Future<List> getTeacherNames();
  Future<List> getStudentNames();
  Future<void> createChatRoom(String chatRoomId, chatRoomMap);
  Future<void> addConversationMessages(String chatRoomId, messageMap);

  Stream<QuerySnapshot<Map<String, dynamic>>> getConversationMessages(
      String chatRoomId);
  Future<List> getAllStudentChats(User user);
  Future<List> getAllTeacherChats(User user);

  Future<Map<String, dynamic>> getTeacherData(User user);

  Future<void> updateTeacherData(UpdateTeacher teacher, String uid);
}

class DatabaseService extends DBBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
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

  @override
  Future<String> getUserType(User user) async {
    final DocumentSnapshot snapshot = await _firestore
        .collection(AppConfigs.usersCollection)
        .doc(user.uid)
        .get();

    Map data = snapshot.data() as Map;

    return data[AppConfigs.userType];
  }

  @override
  Future<String> getUserName(User user) async {
    final DocumentSnapshot snapshot = await _firestore
        .collection(AppConfigs.usersCollection)
        .doc(user.uid)
        .get();

    Map data = snapshot.data() as Map;

    return data[AppConfigs.fullName];
  }

  @override
  Future<List> getTeacherNames() async {
    List<QueryDocumentSnapshot> teacherNames = [];
    try {
      final snapshot =
          await _firestore.collection(AppConfigs.usersCollection).get();

      var documents = snapshot.docs;

      List<QueryDocumentSnapshot> filteredObject = documents
          .where(
              (doc) => doc.get(AppConfigs.userType) == AppConfigs.teacherType)
          .toList();

      for (var element in filteredObject) {
        teacherNames.add(element);
      }

      return teacherNames;
    } catch (e) {
      print(
          'Error occurred while fetching data from firestore ${e.toString()}');
      return teacherNames;
    }
  }

  @override
  Future<List> getStudentNames() async {
    List<QueryDocumentSnapshot> studentNames = [];
    try {
      final snapshot =
          await _firestore.collection(AppConfigs.usersCollection).get();

      var documents = snapshot.docs;

      List<QueryDocumentSnapshot> filteredObject = documents
          .where(
              (doc) => doc.get(AppConfigs.userType) == AppConfigs.studentType)
          .toList();

      for (var element in filteredObject) {
        studentNames.add(element);
      }

      return studentNames;
    } catch (e) {
      print(
          'Error occurred while fetching data from firestore ${e.toString()}');
      return studentNames;
    }
  }

  //Update & Delete is pending

  @override
  Future<void> createChatRoom(String chatRoomId, chatRoomMap) async {
    try {
      await _firestore
          .collection(AppConfigs.chatRoomCollection)
          .doc(chatRoomId)
          .set(chatRoomMap);
    } catch (e) {
      print('Something went wrong while creating chat room ${e.toString()}');
    }
  }

  @override
  Future<void> addConversationMessages(String chatRoomId, messageMap) async {
    try {
      await _firestore
          .collection(AppConfigs.chatRoomCollection)
          .doc(chatRoomId)
          .collection(AppConfigs.messagesCollection)
          .add(messageMap);
    } catch (e) {
      print('Something went wrong while sending message ${e.toString()}');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getConversationMessages(
      String chatRoomId) {
    return _firestore
        .collection(AppConfigs.chatRoomCollection)
        .doc(chatRoomId)
        .collection(AppConfigs.messagesCollection)
        .orderBy('time', descending: true)
        .snapshots();
  }

  @override
  Future<List<DocumentSnapshot>> getAllStudentChats(User user) async {
    List<QueryDocumentSnapshot> studentChatNamesList = [];

    List<DocumentSnapshot> listOfChats = [];
    try {
      final snapshot =
          await _firestore.collection(AppConfigs.chatRoomCollection).get();

      var documents = snapshot.docs;

      List<QueryDocumentSnapshot> filteredObject =
          documents.where((doc) => doc.id.contains(user.uid)).toList();

      // print('filetered list ${filteredObject.first.id}');

      filteredObject.forEach((doc) {
        studentChatNamesList.add(doc);
      });

      //student docs get done which chat is done already
      // studentChatNamesList => documents of chatRoom
      studentChatNamesList.forEach((doc) async {
        List<dynamic> docs =
            doc.get(AppConfigs.usersCollection) as List<dynamic>;

        List chatUserUid =
            docs.where((element) => element != user.uid).toList();

        // print(chatUserUid);
        // print('Chat user id ' + chatUserUid[0]);

        DocumentSnapshot snapshot = await _firestore
            .collection(AppConfigs.usersCollection)
            .doc(chatUserUid[0])
            .get();

        // Map xyz = snapshot.data() as Map;
        listOfChats.add(snapshot);
      });

      return listOfChats;
    } catch (e) {
      print(
          'Error occurred while fetching data from firestore ${e.toString()}');
      return listOfChats;
    }
  }

  @override
  Future<List<DocumentSnapshot>> getAllTeacherChats(User user) async {
    List<QueryDocumentSnapshot> teacherChatNamesList = [];

    List<DocumentSnapshot> listOfChats = [];
    try {
      final snapshot =
          await _firestore.collection(AppConfigs.chatRoomCollection).get();

      var documents = snapshot.docs;

      List<QueryDocumentSnapshot> filteredObject =
          documents.where((doc) => doc.id.contains(user.uid)).toList();

      // print('filetered list ${filteredObject.first.id}');

      filteredObject.forEach((doc) {
        teacherChatNamesList.add(doc);
      });

      //student docs get done which chat is done already
      // studentChatNamesList => documents of chatRoom
      teacherChatNamesList.forEach((doc) async {
        List<dynamic> docs =
            doc.get(AppConfigs.usersCollection) as List<dynamic>;

        List chatUserUid =
            docs.where((element) => element != user.uid).toList();

        // print(chatUserUid);
        // print('Chat user id ' + chatUserUid[0]);

        DocumentSnapshot snapshot = await _firestore
            .collection(AppConfigs.usersCollection)
            .doc(chatUserUid[0])
            .get();

        // Map xyz = snapshot.data() as Map;
        listOfChats.add(snapshot);
      });

      return listOfChats;
    } catch (e) {
      print(
          'Error occurred while fetching data from firestore ${e.toString()}');
      return listOfChats;
    }
  }

  @override
  Future<Map<String, dynamic>> getTeacherData(User user) async {
    try {
      final snapshot = await _firestore
          .collection(AppConfigs.usersCollection)
          .doc(user.uid)
          .get();

      var teacherData = snapshot.data() as Map<String, dynamic>;

      return teacherData;
    } catch (e) {
      print(
          'Error occurred while fetching data from firestore ${e.toString()}');

      throw Exception(ErrorStrings.dataLoadError);
    }
  }

  @override
  Future<void> updateTeacherData(UpdateTeacher teacher, String uid) async {
    try {
      await _firestore
          .collection(AppConfigs.usersCollection)
          .doc(uid)
          .set(teacher.toJson(), SetOptions(merge: true));
    } catch (e) {
      print(
          'Exception occurred while saving data to firestore ${e.toString()}');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etutor/constants/configs.dart';
import 'package:etutor/core/models/person.dart';
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
}

class DatabaseService extends DBBase {
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

  Future<String> getUserName(User user) async {
    final DocumentSnapshot snapshot = await _firestore
        .collection(AppConfigs.usersCollection)
        .doc(user.uid)
        .get();

    Map data = snapshot.data() as Map;

    return data[AppConfigs.fullName];
  }

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

      filteredObject.forEach((element) {
        teacherNames.add(element);
      });

      return teacherNames;
    } catch (e) {
      print(
          'Error occurred while fetching data from firestore ${e.toString()}');
      return teacherNames;
    }
  }

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

      filteredObject.forEach((element) {
        studentNames.add(element);
      });

      return studentNames;
    } catch (e) {
      print(
          'Error occurred while fetching data from firestore ${e.toString()}');
      return studentNames;
    }
  }

  //Update & Delete is pending

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

  Stream<QuerySnapshot<Map<String, dynamic>>> getConversationMessages(
      String chatRoomId) {
    return _firestore
        .collection(AppConfigs.chatRoomCollection)
        .doc(chatRoomId)
        .collection(AppConfigs.messagesCollection)
        .orderBy('time', descending: true)
        .snapshots();
  }

  //work in this function
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

      print('filetered list ${filteredObject.first.id}');

      filteredObject.forEach((doc) {
        studentChatNamesList.add(doc);
      });

      //student docs get done which chat is done already
      // studentChatNamesList => documents of chatRoom
      studentChatNamesList.forEach((doc) async {
        List<dynamic> docs = doc.get('users') as List<dynamic>;

        List chatUserUid =
            docs.where((element) => element != user.uid).toList();

        print(chatUserUid);

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
}

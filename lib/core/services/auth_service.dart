import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/strings/error_strings.dart';
import 'package:etutor/core/models/person.dart';
import 'package:etutor/core/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User? get currentUser;

  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> createAccount(Person person);
  Future<void> signOut();
}

class AuthService extends AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final _dbService = DatabaseService();

  @override
  User? get currentUser {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<AuthResponse> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        String userType = await _dbService.getUserType(userCredential.user!);

        return AuthResponse(status: true, message: userType);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.userNotFound) {
        return AuthResponse(status: false, message: ErrorStrings.userNotFound);
      } else if (e.code == AppStrings.wrongPassword) {
        return AuthResponse(status: false, message: ErrorStrings.wrongPassword);
      }
    } catch (e) {
      return AuthResponse(
          status: false, message: ErrorStrings.somethingWentWrong);
    }

    return AuthResponse(
        status: false, message: ErrorStrings.somethingWentWrong);
  }

  @override
  Future<AuthResponse> createAccount(Person person) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: person.email, password: person.password);

      if (userCredential.user != null) {
        //Account Created Successfully

        await _dbService.saveAccountData(person, userCredential.user!.uid);

        return AuthResponse(status: true, message: '');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.weakPassword) {
        return AuthResponse(
            status: false, message: ErrorStrings.passwordTooWeak);
      } else if (e.code == AppStrings.emailAlreadyInUse) {
        return AuthResponse(
            status: false, message: ErrorStrings.accountAlreadyExists);
      }
    } catch (e) {
      return AuthResponse(
          status: false, message: ErrorStrings.somethingWentWrong);
    }

    return AuthResponse(
        status: false, message: ErrorStrings.somethingWentWrong);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

class AuthResponse {
  bool status;
  String message;

  AuthResponse({required this.status, required this.message});
}

import 'package:etutor/constants/strings/app_strings.dart';
import 'package:etutor/constants/strings/error_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<AuthResponse> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        return AuthResponse(status: true, message: '');
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

  Future<AuthResponse> createAccount(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
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
}

class AuthResponse {
  bool status;
  String message;

  AuthResponse({required this.status, required this.message});
}

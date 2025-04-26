import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/app_routes/routes.dart';
import '../../core/widgets/custom_toast_show.dart';
import '../exception/auth_exception.dart';
import 'package:get/get.dart';

import '../shared_preference/shared_preference_services.dart';

class UserProvider {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ToastClass toast = ToastClass();

  /// Signs in a user with email and password.
  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await storeUserId(userCredential.user?.uid);
    } on FirebaseAuthException catch (e) {
      String errorMessage = getAuthErrorMessage(e);
      toast.showCustomToast(errorMessage);
      throw AuthException(errorMessage);
    }
  }

  /// Registers a new user with email and password.
  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      await storeUserId(userCredential.user?.uid);
    } on FirebaseAuthException catch (e) {
      String errorMessage = getAuthErrorMessage(e);
      toast.showCustomToast(errorMessage);
      throw AuthException(errorMessage);
    }
  }

/// User Sign out
  Future<void> signOut() async {
    try {
      await auth.signOut().then((value) async{
        return await PreferenceHelper.removeData('userID').then((value)async {
          Get.offAllNamed(AppRoutes.SIGNINSCREEN);
          toast.showCustomToast("Sign out Successfully");
        },);
      },);
    } catch (e) {
      log("Error signing out: $e");
    }
  }

  /// Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      toast.showCustomToast("Password reset email sent to\n$email");
      log("Password reset email sent to $email");
    } catch (e) {
      toast.showCustomToast("Failed to send password reset email\n$e");
      log("Failed to send password reset email: $e");
      throw Exception("Failed to send password reset email: $e");
    }
  }

  /// Stores the current user ID in SharedPreferences.
  Future<void> storeUserId(String? userId) async {
      await PreferenceHelper.setString('userID', userId!);
  }

  /// Maps Firebase authentication errors to user-friendly messages.
  String getAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}

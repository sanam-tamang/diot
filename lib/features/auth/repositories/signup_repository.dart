

import 'package:firebase_auth/firebase_auth.dart' as auth;

const String _errorMessage =
    "An error occurred while signing up. Please try again later.";

abstract class BaseSignupRepository {
  Future<void> signUpWithEmailAndPassword(String email, String password);
}

class SignupRepository implements BaseSignupRepository {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Additional code for handling user creation success
      // For example, you can save user details to a database or perform any other necessary actions.
    } on auth.FirebaseAuthException catch (e) {
      throw e.message ?? _errorMessage;
    } catch (e) {
      // Handle any other exceptions that may occur during the sign-up process
      throw _errorMessage;
    }
  }
}

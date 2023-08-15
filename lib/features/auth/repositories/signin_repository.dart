import 'package:firebase_auth/firebase_auth.dart';

const String _errorMessage =
    'An error occurred while signing in. Please try again later.';

abstract class BaseSignInRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);
}

class SignInRepository implements BaseSignInRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Additional code for handling successful sign-in
      // For example, you can save user details to local storage or perform any other necessary actions.
    } on FirebaseAuthException catch (e) {
      throw e.message ?? _errorMessage;
    } catch (e) {
      // Handle any other exceptions that may occur during the sign-in process
      throw _errorMessage;
    }
  }
}

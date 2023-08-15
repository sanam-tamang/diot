import 'package:firebase_auth/firebase_auth.dart';

class UserLogoutRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> logOut() async {
   await _firebaseAuth.signOut();
  }
}

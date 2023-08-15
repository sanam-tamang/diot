import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseUserRepository {
  Stream<User?>? get currentStreamUser;
  User? get currentUser;
}

class UserRepository implements BaseUserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
 
  UserRepository._();
  static UserRepository getInstance() => UserRepository._();

  @override
  User? get currentUser => _auth.currentUser;
  @override
  Stream<User?>? get currentStreamUser => _auth.authStateChanges();

  
}

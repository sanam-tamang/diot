import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/model/user.dart';

class SearchRepository {
  SearchRepository._();
  static SearchRepository get instance => SearchRepository._();
  final _firestore = FirebaseFirestore.instance;

  Future<List<User>?> seachUser(String username) async {
    final query = await _firestore
        .collection('user')
        .where('name', isGreaterThanOrEqualTo: username)
        .where('name', isLessThanOrEqualTo: username)
        .where('name', isEqualTo: username)
        .get();

    return query.docs.map((doc) {
      final Map<String, dynamic> data = doc.data();

      return User.fromMap(data);
    }).toList();
  }
}

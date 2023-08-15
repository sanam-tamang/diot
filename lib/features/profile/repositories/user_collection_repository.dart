import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/core/model/user.dart' as local;
import '../../../core/repositories/image_uploader_repository.dart';
import '../model/profile_user_model.dart';

class UserCollectionRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  UserCollectionRepository._();
  static UserCollectionRepository getInstance() => UserCollectionRepository._();
  Future<void> saveUser(final String name) async {
    try {
      await _firestore.collection('user').doc(_auth.currentUser?.uid).set({
        "id": _auth.currentUser?.uid,
        "email": _auth.currentUser?.email,
        "name": name,
        "followingCount": 0,
        "followerCount": 0,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateUser(UpdateProfileUserModel user) async {
    try {
      Map<String, dynamic> map = {};

      map["name"] = user.name;
      if (user.bio != null) {
        map["bio"] = user.bio;
      }
      if (user.profileImage != null) {
        map["image"] = await ImageUploaderRepository.getInstance()
            .uploadToFirebase(user.profileImage!);
      }
      if (user.isBackgroundImageDeleted) {
        map["backgroundImage"] = null;
      }
      if (user.backgroundImage != null) {
        map["backgroundImage"] = await ImageUploaderRepository.getInstance()
            .uploadToFirebase(user.backgroundImage!);
      }

      if (map.isNotEmpty) {
        // Perform the update only if there are fields to update
        await _firestore.collection('user').doc(user.id).update(map);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  ///[countValue] should increment 1 when following and decrement by 1 when unfollowing
  Future<void> updateFollowingAndFollowerCount(
      {required String currentLoginUser,
      required String followingUserId,
      required int countValue}) async {
    Future.wait([
      ///following count to current login user
      _firestore
          .collection('user')
          .doc(currentLoginUser)
          .update({'followingCount': FieldValue.increment(countValue)}),

      ///following count to current login user
      _firestore
          .collection('user')
          .doc(followingUserId)
          .update({'followerCount': FieldValue.increment(countValue)})
    ]);
  }

//future get
  Future<local.User?> getUser(String userId) async {
    final map = await _firestore.collection('user').doc(userId).get();
    final data = map.data();
    if (data != null) {
      final user = local.User.fromMap(data);
      return user;
    }

    return null;
  }

  
}

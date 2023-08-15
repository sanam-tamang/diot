import 'package:cloud_firestore/cloud_firestore.dart';
import '../../profile/repositories/user_collection_repository.dart';
import '../model/following_follower.dart';

import '../models/follow.dart';

class FollowingFollowersRepository {
  final _firestore = FirebaseFirestore.instance;
  FollowingFollowersRepository._();
 static FollowingFollowersRepository get instance =>  FollowingFollowersRepository._();

  Stream<bool> isFollowing(
      {required String loginUserId, required String visitedUserProfileId}) {
    final snapshot = _firestore
        .collection('user')
        .doc(loginUserId)
        .collection('following')
        .where('followingId', isEqualTo: visitedUserProfileId)
        .snapshots();

    // Transform the stream to return a boolean value
    return snapshot.map((query) {
      // Check if any document exists in the query results
      return query.docs.isNotEmpty;
    });
  }

  Future<void> followUser(Follow follow) async {
    await Future.wait([
      _addFollowingUser(follow),
      _addFollwerUser(follow),
      UserCollectionRepository.getInstance().updateFollowingAndFollowerCount(
          currentLoginUser: follow.userId,
          followingUserId: follow.followingId,
          countValue: 1),
    ]);
  }


  Future<void> unFollowUser(Follow follow) async {
    await Future.wait([
      ///delete from follower collection of another user
     _firestore
        .collection('user')
        .doc(follow.followingId)
        .collection('followers').doc(follow.userId).delete(),

///delete from for following from current login user
         _firestore
          .collection('user')
          .doc(follow.userId)
          .collection('following')
          .doc(follow.followingId)
          .delete(),
        
      UserCollectionRepository.getInstance().updateFollowingAndFollowerCount(
          currentLoginUser: follow.userId,
          followingUserId: follow.followingId,
          countValue: -1),
    ]);
  }

  Future<void> _addFollwerUser(Follow follow) async {
    //add followers to the following of loginuser
    await _firestore
        .collection('user')
        .doc(follow.followingId)
        .collection('followers').doc(follow.userId)
        .set(follow.followerUserToMap());
  }

  Future<void> _addFollowingUser(Follow follow) async {
    ///add following to loginuserId
    await _firestore
        .collection('user')
        .doc(follow.userId)
        .collection('following').doc(follow.followingId)
        .set(follow.followingUserToMap());
  }

  Stream<FollowingAndFollowers> getFollowingAndFollowers(String userId) {
    final snapshot = _firestore.collection('user').doc(userId).snapshots();
    return snapshot.map((query) {
      
      final data = query.data();
   
      if (data != null) {
        final user =FollowingAndFollowers.fromMap(data);
        return user;
      } else {
        return const  FollowingAndFollowers(followers: 0, following: 0);
      }
    });
  }
}

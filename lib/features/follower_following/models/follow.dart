

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Follow extends Equatable {
  final String followingId;
  final String userId;
  final Timestamp timeStamp;
  const Follow({
    required this.followingId,
    required this.userId,
    required this.timeStamp,
  });
  
  @override
  List<Object> get props => [followingId, userId, timeStamp];

///when login user follow to another user
///it will saved to current login user collection
  Map<String, dynamic> followingUserToMap() {
    return <String, dynamic>{
      'followingId': followingId,
      'timeStamp': timeStamp,
    };
  }

///followed user following by login user
//////it will be saved to another user  collection
    Map<String, dynamic> followerUserToMap() {
    return <String, dynamic>{
      'followerId': userId,
      'timeStamp': timeStamp,
    };
  }

  
}

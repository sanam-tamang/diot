

import 'package:equatable/equatable.dart';

class FollowingAndFollowers extends Equatable {
  final int followers;
  final int following;
  const FollowingAndFollowers({
    required this.followers,
    required this.following,
  });

  @override
  List<Object> get props => [followers, following];

  

  factory FollowingAndFollowers.fromMap(Map<String, dynamic> map) {
    return FollowingAndFollowers(
      followers: map['followerCount'] ??0,
      following: map['followingCount'] ??0,
    );
  }

 
}

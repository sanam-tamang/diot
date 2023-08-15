import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../auth/repositories/user_repository.dart';
import '../../repositories/following_followers_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/follow.dart';

part 'following_state.dart';

///Follow and unfollow cubit
class FollowingCubit extends Cubit<FollowingState> {
  FollowingCubit()
      : 
        super(FollowingInitial());
  late StreamSubscription<bool> _streamSubscription;

  void isFollowing({required String correntlyVisitedProfileId}) {
    emit(FollowingLoading());

    try {
      _streamSubscription = FollowingFollowersRepository.instance
          .isFollowing(
              loginUserId: UserRepository.getInstance().currentUser!.uid,
              visitedUserProfileId: correntlyVisitedProfileId)
          .listen((isFollowing) {
        emit(FollowingLoaded(isFollowing: isFollowing));
      });
    } catch (e) {
      emit(FollowingFailure(message: e.toString()));
    }
  }

  Future<void> followUser({required String visitedProfileUserId}) async {
    emit(FollowingLoading());

    await FollowingFollowersRepository.instance.followUser(Follow(
        followingId: visitedProfileUserId,
        userId: UserRepository.getInstance().currentUser!.uid,
        timeStamp: Timestamp.now()));

    // isFollowing(correntlyVisitedProfileId: visitedProfileUserId);
  }

  Future<void> unFollowUser({required String visitedProfileUserId}) async {
    emit(FollowingLoading());
    await FollowingFollowersRepository.instance.unFollowUser(Follow(
        followingId: visitedProfileUserId,
        userId: UserRepository.getInstance().currentUser!.uid,
        timeStamp: Timestamp.now()));


  }

  

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}

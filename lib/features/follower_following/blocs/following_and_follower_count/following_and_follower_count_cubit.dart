import 'dart:async';

import '../../repositories/following_followers_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/following_follower.dart';

part 'following_and_follower_count_state.dart';

class FollowingAndFollowerCountCubit
    extends Cubit<FollowingAndFollowerCountState> {
  FollowingAndFollowerCountCubit() : super(FollowingAndFollowerCountInitial());
  late StreamSubscription<FollowingAndFollowers> _streamSubscription;

  ///[userId] which currently visited user id
  void getFollowersAndFollowingUsers({required String userId}) {
    try {
      emit(FollowingAndFollowerCountLoading());
      _streamSubscription = FollowingFollowersRepository.instance
          .getFollowingAndFollowers(userId)
          .listen((data) {
        emit(FollowingAndFollowerCountLoaded(followingAndFollowers: data));
      });
    } catch (e) {
      emit(FollowingAndFollowerCountFailure());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}

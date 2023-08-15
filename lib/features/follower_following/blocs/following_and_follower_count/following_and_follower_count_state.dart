// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'following_and_follower_count_cubit.dart';

abstract class FollowingAndFollowerCountState extends Equatable {
  const FollowingAndFollowerCountState();

  @override
  List<Object> get props => [];
}

class FollowingAndFollowerCountInitial extends FollowingAndFollowerCountState {}

class FollowingAndFollowerCountLoading extends FollowingAndFollowerCountState {}

class FollowingAndFollowerCountLoaded extends FollowingAndFollowerCountState {
  final FollowingAndFollowers followingAndFollowers;
  const FollowingAndFollowerCountLoaded({
    required this.followingAndFollowers,
  });
    @override
  List<Object> get props => [followingAndFollowers];
}

class FollowingAndFollowerCountFailure extends FollowingAndFollowerCountState {}

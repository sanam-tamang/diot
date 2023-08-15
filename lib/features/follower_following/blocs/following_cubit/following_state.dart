part of 'following_cubit.dart';

sealed class FollowingState extends Equatable {
  const FollowingState();

  @override
  List<Object> get props => [];
}

final class FollowingInitial extends FollowingState {}

final class FollowingLoading extends FollowingState {}

final class FollowingLoaded extends FollowingState {
  final bool isFollowing;

 const  FollowingLoaded({required this.isFollowing});
   @override
  List<Object> get props => [isFollowing];

}

final class FollowingFailure extends FollowingState {
    final String message;

 const  FollowingFailure({required this.message});
   @override
  List<Object> get props => [message];
}

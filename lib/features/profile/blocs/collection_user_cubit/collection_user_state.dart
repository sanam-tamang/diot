// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'collection_user_cubit.dart';

abstract class CollectionUserState extends Equatable {
  const CollectionUserState();

  @override
  List<Object> get props => [];
}

class CollectionUserInitial extends CollectionUserState {}

class CollectionUserLoading extends CollectionUserState {}

class CollectionUserFailure extends CollectionUserState {
  final String message;
  final String code;
  const CollectionUserFailure({
    required this.message,
    required this.code,
  });

  @override
  List<Object> get props => [message, code];
}

class CollectionUserLoaded extends CollectionUserState {
  final User user;
  ///it will help to people who are visited the profile page
  final List<String> visitedProfileUserId;
  const CollectionUserLoaded({
    required this.user,
    required this.visitedProfileUserId,
  });
  @override
  List<Object> get props => [user];
}

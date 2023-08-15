// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserAuthenticatedState extends UserState {
  final auth.User user;
  const UserAuthenticatedState({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class UserUnAuthenticatedState extends UserState {}

class UserLoadingState extends UserState {}

part of 'messaged_users_cubit.dart';

sealed class MessagedUsersState extends Equatable {
  const MessagedUsersState();

  @override
  List<Object> get props => [];
}

final class MessagedUsersInitial extends MessagedUsersState {}

final class MessagedUsersLoading extends MessagedUsersState {}

final class MessagedUsersLoaded extends MessagedUsersState {
  final List<ChatRoomIndividual> messagedUsers;

  const MessagedUsersLoaded({required this.messagedUsers});
  @override
  List<Object> get props => [messagedUsers];
}

final class MessagedUsersFailure extends MessagedUsersState {
  final String message;

 const  MessagedUsersFailure({required this.message});

   @override
  List<Object> get props => [message];
}

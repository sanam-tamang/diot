part of 'message_cubit.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

final class MessageInitial extends MessageState {}

final class MessageLoading extends MessageState {}

final class MessageLoaded extends MessageState {
  final List<GetMessage> messages;

  const MessageLoaded({required this.messages});
  @override
  List<Object> get props => [messages];
}

final class MessageFailure extends MessageState {
  final String message;

  const MessageFailure({required this.message});
    @override
  List<Object> get props => [message];
}

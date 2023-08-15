// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:devmandu/core/model/user.dart';

///chat room id with with messaId
class ChatRoomIndividual extends Equatable {
  final String chatRoomId;
  final String? lastMessage;
  final DateTime? lastMessageTime;

  ///user id who receive the message
  final User messagedUser;
  const ChatRoomIndividual({
    required this.chatRoomId,
    this.lastMessage,
    this.lastMessageTime,
    required this.messagedUser,
  });
  @override
  List<Object?> get props => [chatRoomId, lastMessage, lastMessageTime, messagedUser];
}

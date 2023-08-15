

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CreateMessage extends Equatable {
  final String chatRoomId;
  final String sendBy;
  final String message;
  const CreateMessage({
    required this.chatRoomId,
    required this.sendBy,
    required this.message,
  });

  @override
  List<Object> get props => [chatRoomId, sendBy, message];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sendBy': sendBy,
      'message': message,
    };
  }

  
}

class GetMessage extends Equatable {
  final String messageId;
  final String sendBy;
  final String message;
  final DateTime timestamp;
  const GetMessage({
    required this.messageId,
    required this.sendBy,
    required this.message,
    required this.timestamp,
  });

  @override
  List<Object> get props => [messageId, sendBy, message, timestamp];

  factory GetMessage.fromMap(Map<String, dynamic> map) {
    final  Timestamp timestamp =  map['timestamp'];
    return GetMessage(
      messageId: map['messageId'] as String,
      sendBy: map['sendBy'] as String,
      message: map['message'] as String,
      timestamp:timestamp.toDate(),
    );
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:devmandu/features/auth/repositories/user_repository.dart';
import 'package:devmandu/features/message/models/message.dart';
import 'package:devmandu/features/profile/repositories/user_collection_repository.dart';
import 'package:uuid/uuid.dart';

import '../models/chat_room.dart';

class MessageRepository {
  MessageRepository._();
  static MessageRepository get instance => MessageRepository._();
  final _firestore = FirebaseFirestore.instance;
  Future<void> sendMessage(CreateMessage message) async {
    final chatRoom =
        _firestore.collection('chatRoomIndividual').doc(message.chatRoomId);

    await chatRoom.update({
      "lastMessage": message.message,
      "timestamp": Timestamp.now(),
      "sendBy": message.sendBy
    });
    final uuid = const Uuid().v1();
    await chatRoom.collection('chat').doc(uuid).set(
        {...message.toMap(), "messageId": uuid, "timestamp": Timestamp.now()});
  }

  Stream<List<GetMessage>> getMessages(String chatRoomId) {
    final snapshot = _firestore
        .collection('chatRoomIndividual')
        .doc(chatRoomId)
        .collection('chat')
        .orderBy('timestamp', descending: false)
        .snapshots();

    return snapshot.asyncMap((query) {
      return Future.wait(query.docs.map((doc) async {
        final data = doc.data();
        return GetMessage.fromMap(data);
      }));
    });
  }
}

class ChatRoomRepository {
  final _firestore = FirebaseFirestore.instance;
  final _currentUser = UserRepository.getInstance().currentUser!.uid;
  ChatRoomRepository._();
  static ChatRoomRepository get instance => ChatRoomRepository._();
  Future<void> createChatRoom(String messagedUserId) async {
    final uuid = const Uuid().v1();
    await _firestore.collection('chatRoomIndividual').doc(uuid).set({
      'participants': [messagedUserId, _currentUser],
      'chatRoomId': uuid,
      'timestamp': Timestamp.now()
    });
  }

  Stream<List<ChatRoomIndividual>> getMessagedUsers() async* {
    final snapshot = _firestore
        .collection('chatRoomIndividual')
        .orderBy("timestamp", descending: true)
        .where('participants', arrayContains: _currentUser)
        .snapshots();

    yield* snapshot.asyncMap((query) {
      final queryDoc = Future.wait(query.docs.map((doc) async {
        final Map<String, dynamic> data = doc.data();

        final List participants = data['participants'];
        final messagedUserId =
            participants.where((participant) => participant != _currentUser);
        final user = await UserCollectionRepository.getInstance()
            .getUser(messagedUserId.first);

        final Timestamp timestamp = data['timestamp'] ?? Timestamp.now();
        return ChatRoomIndividual(
          chatRoomId: data['chatRoomId'],
          messagedUser: user!,
          lastMessage: data['lastMessage'],
          lastMessageTime: timestamp.toDate(),
        );
      }));

      return queryDoc;
    });
  }
}

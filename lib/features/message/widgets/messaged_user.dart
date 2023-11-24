// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devmandu/core/config/route/route_name.dart';
import 'package:flutter/material.dart';

import 'package:devmandu/features/message/models/chat_room.dart';

import '../../../core/widgets/build_avatar_image.dart';

class MessagedUser extends StatelessWidget {
  const MessagedUser({
    super.key,
    required this.chatRoomIndividual,
  });
  final ChatRoomIndividual chatRoomIndividual;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRouteName.chatPage,
          arguments: {"chatRoomIndividual": chatRoomIndividual}),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => _gotoProfile(context, chatroom: chatRoomIndividual),
              child: BuildAvatarImageNetwork(
                image: chatRoomIndividual.messagedUser.image,
              ),
            ),
            Flexible(
              flex: 3,
              child: ListTile(
                title: Text(
                  chatRoomIndividual.messagedUser.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: chatRoomIndividual.lastMessage == null
                    ? const Text("Let's start conversations")
                    : Text(
                        chatRoomIndividual.lastMessage.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _gotoProfile(BuildContext context,
      {required ChatRoomIndividual chatroom}) {
    Navigator.of(context).pushNamed(AppRouteName.profile,
        arguments: {'userId': chatroom.messagedUser.userId});
  }
}

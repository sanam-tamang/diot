import 'package:devmandu/core/config/route/route_name.dart';
import 'package:devmandu/core/widgets/build_avatar_image.dart';

import '../../../core/widgets/custom_circular_progress_widget.dart';
import '../../../core/widgets/custom_error_message_widget.dart';
import '../../auth/repositories/user_repository.dart';
import '../blocs/message_cubit/message_cubit.dart';
import '../models/message.dart';
import 'package:flutter/material.dart';

import '../models/chat_room.dart';
import '../repositories/message_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/theme/app_colors.dart';

///where interaction between two people going on chatting
class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.chatRoomIndividual,
  });
  final ChatRoomIndividual chatRoomIndividual;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();

    fetchMessage();
    super.initState();
  }

  void fetchMessage() {
    context
        .read<MessageCubit>()
        .getMessages(widget.chatRoomIndividual.chatRoomId);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomSheet: SendMessageTextFieldAndButton(
        controller: controller,
        chatRoomIndividual: widget.chatRoomIndividual,
      ),
      body:
          NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            scrolledUnderElevation: 0.0,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => _gotoProfile(context,
                      chatroom: widget.chatRoomIndividual),
                  child: BuildAvatarImageNetwork(
                    radius: 20,
                    image: widget.chatRoomIndividual.messagedUser.image,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  widget.chatRoomIndividual.messagedUser.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            pinned: true,
            backgroundColor: Colors.grey.shade200.withOpacity(0.9),
            elevation: 4,
          ),
        ];
      }, body: SafeArea(
        child: BlocBuilder<MessageCubit, MessageState>(
          builder: (context, state) {
            if (state is MessageLoading) {
              return const CustomCircularProgressIndicator();
            } else if (state is MessageFailure) {
              return CustomErrorMessageWidget(message: state.message);
            } else if (state is MessageLoaded) {
              final messages = state.messages;
              return _BuidMessages(messages: messages);
            } else {
              return const SizedBox();
            }
          },
        ),
      )),
    );
  }

  void _gotoProfile(BuildContext context,
      {required ChatRoomIndividual chatroom}) {
    Navigator.of(context).pushNamed(AppRouteName.profile,
        arguments: {'userId': chatroom.messagedUser.userId});
  }
}

class _BuidMessages extends StatelessWidget {
  const _BuidMessages({
    required this.messages,
  });

  final List<GetMessage>? messages;

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(30);

    return messages == null
        ? const SizedBox.shrink()
        : ListView.builder(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom + 100),
            itemCount: messages?.length,
            itemBuilder: (context, index) {
              final message = messages?[index];
              bool isLoginUser = message!.sendBy ==
                  UserRepository.getInstance().currentUser!.uid;
              return Row(
                mainAxisAlignment: isLoginUser
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  isLoginUser ? const Spacer() : const SizedBox(),
                  Flexible(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 12),
                      decoration: BoxDecoration(
                          color: isLoginUser ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: radius,
                              topRight: radius,
                              bottomRight: isLoginUser ? radius : Radius.zero,
                              bottomLeft: isLoginUser ? Radius.zero : radius)),
                      child: Text(
                        message.message,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 15,
                            color: isLoginUser ? Colors.white : Colors.black87),
                      ),
                    ),
                  ),
                  !isLoginUser ? const Spacer() : const SizedBox(),
                ],
              );
            });
  }
}

class SendMessageTextFieldAndButton extends StatefulWidget {
  const SendMessageTextFieldAndButton({
    super.key,
    required this.controller,
    required this.chatRoomIndividual,
  });
  final TextEditingController controller;
  final ChatRoomIndividual chatRoomIndividual;

  @override
  State<SendMessageTextFieldAndButton> createState() =>
      _SendMessageTextFieldAndButtonState();
}

class _SendMessageTextFieldAndButtonState
    extends State<SendMessageTextFieldAndButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    color: AppColors.greyScale7,
                    borderRadius: BorderRadius.circular(25)),
                child: TextFormField(
                  controller: widget.controller,
                  maxLines: 3,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  onChanged: (message) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      suffixIcon: _sendButton(),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "write your message..."),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _sendButton() {
    return IconButton(
        onPressed:
            widget.controller.text.trim().isEmpty ? null : __createMessage,
        icon: Icon(
          Icons.send,
          color: widget.controller.text.trim().isEmpty
              ? AppColors.primary.withOpacity(0.3)
              : AppColors.primary,
        ));
  }

  void __createMessage() async {
    final message = widget.controller.value.text;
    widget.controller.clear();
    await MessageRepository.instance
        .sendMessage(CreateMessage(
            chatRoomId: widget.chatRoomIndividual.chatRoomId,
            sendBy: UserRepository.getInstance().currentUser!.uid,
            message: message))
        .then((value) {});
  }
}

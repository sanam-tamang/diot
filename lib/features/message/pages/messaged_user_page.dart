import 'package:collection/collection.dart';
import '../../../core/config/route/route_name.dart';
import '../../../core/model/user.dart';
import '../../../core/widgets/annoted_region.dart';
import 'package:devmandu/core/widgets/build_avatar_image.dart';
import 'package:devmandu/core/widgets/custom_circular_progress_widget.dart';
import 'package:devmandu/core/widgets/custom_error_message_widget.dart';
import 'package:devmandu/features/auth/repositories/user_repository.dart';
import 'package:devmandu/features/message/blocs/messaged_users_cubit/messaged_users_cubit.dart';
import 'package:devmandu/features/message/models/chat_room.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../searcg/blocs/search_user_cubit/search_user_cubit.dart';
import '../../searcg/widgets/search_box.dart';
import '../repositories/message_repository.dart';
import '../widgets/messaged_user.dart';

class MessagedUserPage extends StatefulWidget {
  const MessagedUserPage({super.key});

  @override
  State<MessagedUserPage> createState() => _MessagedUserPageState();
}

class _MessagedUserPageState extends State<MessagedUserPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: CustomAnnotatedRegion(
          color: Colors.grey.shade100,
          child: SafeArea(
              child: NestedScrollView(
            headerSliverBuilder: (context, isHeader) {
              return [
                SliverAppBar(
                  scrolledUnderElevation: 0.0,
                  pinned: true,
                  backgroundColor: Colors.grey.shade100,
                  elevation: 8,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Message'),
                      IconButton(
                          onPressed: _showSearchButton, icon: _addMessageIcon())
                    ],
                  ),
                )
              ];
            },
            body: BlocBuilder<MessagedUsersCubit, MessagedUsersState>(
                builder: (context, state) {
              if (state is MessagedUsersLoading) {
                return const CustomCircularProgressIndicator();
              } else if (state is MessagedUsersFailure) {
                return CustomErrorMessageWidget(
                  message: state.message,
                );
              } else if (state is MessagedUsersLoaded) {
                final users = state.messagedUsers;
                return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return MessagedUser(chatRoomIndividual: users[index]);
                    });
              } else {
                return const SizedBox();
              }
            }),
          ))),
    );
  }

  Stack _addMessageIcon() {
    return const Stack(
      clipBehavior: Clip.none,
      children: [
        FaIcon(
          Icons.email_rounded,
          size: 28,
        ),
        Positioned(
          bottom: 0,
          right: -2,
          child: CircleAvatar(
            backgroundColor: Colors.black54,
            radius: 7,
            child: FaIcon(
              Icons.add,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showSearchButton() async {
    final searchController = TextEditingController();
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return BlocProvider(
            create: (context) => SearchUserCubit(),
            child: Builder(builder: (context) {
              return SafeArea(
                child: Container(
                  color: Colors.grey.shade200,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      Flexible(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.arrow_back)),
                            Expanded(
                              child: SearchBox(
                                controller: searchController,
                                hintText: 'Search users',
                                onSubmit: () {
                                  context.read<SearchUserCubit>().getUsers(
                                      searchController.value.text.trim());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<SearchUserCubit, SearchUserState>(
                          builder: (context, state) {
                            if (state is SearchUserLoading) {
                              return const CustomCircularProgressIndicator();
                            } else if (state is SearchUserLoaded) {
                              return ListView.builder(
                                  itemCount: state.users?.length,
                                  itemBuilder: (context, index) {
                                    final user = state.users![index];
                                    return _filterMessagedUser(user);
                                  });
                            } else if (state is SearchUserFailure) {
                              return CustomErrorMessageWidget(
                                  message: state.message);
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  BlocBuilder<MessagedUsersCubit, MessagedUsersState> _filterMessagedUser(
      User user) {
    return BlocBuilder<MessagedUsersCubit, MessagedUsersState>(
      builder: (context, state) {
        if (state is MessagedUsersLoaded) {
          ///check whether user has already talk with that userid or not
          ChatRoomIndividual? chatRoomUser =
              state.messagedUsers.firstWhereOrNull(
            (element) => element.messagedUser.userId == user.userId,
          );
          return chatRoomUser == null
              ? _BuildUsers(user: user)
              : MessagedUser(chatRoomIndividual: chatRoomUser);
        }
        return _BuildUsers(user: user);
      },
    );
  }
}

class _BuildUsers extends StatelessWidget {
  const _BuildUsers({
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return user.userId == UserRepository.getInstance().currentUser?.uid
        ? const SizedBox.shrink()
        : ListTile(
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                AppRouteName.profile,
                arguments: {"userId": user.userId},
              ),
              child: SizedBox(
                  height: 60,
                  width: 60,
                  child: BuildAvatarImageNetwork(image: user.image)),
            ),
            title: Text(user.name),
            trailing: IconButton(
                onPressed: () {
                  ChatRoomRepository.instance.createChatRoom(user.userId);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.add_circle)),
          );
  }
}

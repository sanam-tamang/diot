import '../../models/chat_room.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/message_repository.dart';

part 'messaged_users_state.dart';

class MessagedUsersCubit extends Cubit<MessagedUsersState> {
  MessagedUsersCubit() : super(MessagedUsersInitial());

  void getMessagedUsers() {
    emit(MessagedUsersLoading());
    try {
      ChatRoomRepository.instance.getMessagedUsers().listen((messagedUsers) {
        emit(MessagedUsersLoaded(messagedUsers: messagedUsers));
      });
    } catch (e) {
      emit(MessagedUsersFailure(message: e.toString()));
    }
  }
}

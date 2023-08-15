import 'dart:async';

import '../../models/message.dart';
import '../../repositories/message_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());
  late StreamSubscription _subscription;

  void getMessages(String chatRoomId) {
    emit(MessageLoading());
    try {
      _subscription =
          MessageRepository.instance.getMessages(chatRoomId).listen((messages) {
        emit(MessageLoaded(messages: messages));
      });
    } catch (e) {
      emit(MessageFailure(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}

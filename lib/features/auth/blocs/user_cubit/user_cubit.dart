

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/user_repository.dart';




part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository repository;
  UserCubit({required this.repository}) : super(UserInitial());

  void currentUser() {
    try {
      repository.currentStreamUser?.listen((user) async {
        if (user != null) {
          emit(UserAuthenticatedState(user: user));
        } else {
          emit(UserUnAuthenticatedState());
        }
      });
    } catch (e) {
      emit(UserUnAuthenticatedState());
    }
  }
}

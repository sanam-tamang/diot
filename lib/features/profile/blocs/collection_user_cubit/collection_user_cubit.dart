import 'dart:async';

import '../../repositories/user_collection_repository.dart';
import '../../../auth/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/user.dart';

part 'collection_user_state.dart';

class CollectionUserCubit extends Cubit<CollectionUserState> {
  CollectionUserCubit({required UserCollectionRepository repository})
      : _repository = repository,
        super(CollectionUserInitial());
  final UserCollectionRepository _repository;

  Future<void> getUserData({required String userId}) async {
    final state = this.state;

    try {
      emit(CollectionUserLoading());
      final user = await _repository.getUser(userId);

      ///if data is being loaded
      if (state is CollectionUserLoaded) {
        final newList = state.visitedProfileUserId;

        ///if current login user is visited profile page after loaded it will clear list of visited
        ///profile
        if (UserRepository.getInstance().currentUser?.uid == user!.userId) {
          newList.clear();
        }

        newList.add(user.userId);
        emit(CollectionUserLoaded(visitedProfileUserId: newList, user: user));
        return;
      }

      ///if not loaded it will be called first time
      emit(CollectionUserLoaded(
          visitedProfileUserId: [user!.userId], user: user));
    } catch (e) {
     
      emit(const CollectionUserFailure(
          message: 'Something went wrong', code: '400'));
    }
  }

  ///this function will help to get the previously visted userId of the profile page
  ///base on that id we again going to fetch the data to show user info
  Future<void> getPreviouslyVisitedUser() async {
    final state = this.state;

    try {
      emit(CollectionUserLoading());

      ///if data is being loaded
      if (state is CollectionUserLoaded) {
        final newList = state.visitedProfileUserId;
        newList.removeLast();
        if (newList.isEmpty) return;
        final user = await _repository.getUser(newList.last);
        // if (UserRepository.getInstance().currentUser?.uid == user!.userId) {
        //   newList.clear();
        // }

        emit(CollectionUserLoaded(visitedProfileUserId: newList, user: user!));
        return;
      }
    } catch (e) {
      emit(const CollectionUserFailure(
          message: 'Something went wrong', code: '400'));
    }
  }
}

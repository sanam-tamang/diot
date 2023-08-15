
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/user.dart';
import '../../repositories/search_repository.dart';

part 'search_user_state.dart';

class SearchUserCubit extends Cubit<SearchUserState> {
  SearchUserCubit() : super(SearchUserInitial());

  Future<void> getUsers(String username) async {
    emit(SearchUserLoading());
    try {
      final user = await SearchRepository.instance.seachUser(username);
      emit(SearchUserLoaded(users: user));
    } catch (e) {
      emit(SearchUserFailure(message: e.toString()));
    }
  }
}

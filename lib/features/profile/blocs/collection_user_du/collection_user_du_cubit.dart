import '../../repositories/user_collection_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/profile_user_model.dart';
import '../collection_user_cubit/collection_user_cubit.dart';

part 'collection_user_du_state.dart';

///delete or update user
class CollectionUserDuCubit extends Cubit<CollectionUserDuState> {
  CollectionUserDuCubit({required CollectionUserCubit userCubit})
      : _userCubit = userCubit,
        super(CollectionUserDuInitial());
  final CollectionUserCubit _userCubit;
  Future<void> updateUser(UpdateProfileUserModel user) async {
    emit(CollectionUserDuLoading());
    try {
      await UserCollectionRepository.getInstance().updateUser(user);

      emit(CollectionUserDuSuccess());
      _userCubit.getUserData(userId: user.id);
    } catch (e) {
      emit(CollectionUserDuFailure(message: e.toString()));
    }
  }
}

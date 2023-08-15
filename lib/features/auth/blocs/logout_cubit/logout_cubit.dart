import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/logout_repository.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final UserLogoutRepository repository;
  LogoutCubit({required this.repository})
      : super(LogoutInitial());

  Future<void> logOut() async {
    emit(LogoutLoading());
    try {
      await repository.logOut();
      emit(const LogoutSuccess(message: 'Logout Successful'));
    } catch (e) {
      emit(LogoutSuccess(message: e.toString()));
    }
  }
}

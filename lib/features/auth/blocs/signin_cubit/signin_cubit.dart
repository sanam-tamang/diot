// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/signin_repository.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit({
    required this.signInRepository,
  }) : super(SigninInitial());
  final SignInRepository signInRepository;
  Future<void> signIn({required email,required String password}) async {
    emit(SigninLoading());
    try {
      await signInRepository.signInWithEmailAndPassword(email, password);
      emit(SigninSuccess());
    } catch (e) {
      emit(SigninFailure(e.toString()));
    }
  }
}

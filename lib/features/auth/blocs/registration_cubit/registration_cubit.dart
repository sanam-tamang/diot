// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:devmandu/features/profile/repositories/user_collection_repository.dart';

import '../../models/user_registration_model.dart';
import '../../repositories/signup_repository.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final SignupRepository signupRepository;
  final UserCollectionRepository userCollectionRepo;

  RegistrationCubit({
    required this.signupRepository,
    required this.userCollectionRepo,
  }) : super(RegistrationInitial());

  ///if [UserRegistrationModel] each and and property is not empty then
  ///it will proceed to register otherwise gives validation eror
  Future<void> registerUser(UserRegistrationModel user) async {
    emit(RegisterLoading());
    try {
      await signupRepository.signUpWithEmailAndPassword(
          user.email, user.password);
      await userCollectionRepo.saveUser(user.name);
      emit(RegisterSucess(message: "User registered"));
    } catch (e) {
      emit(RegisterFailure(message: e.toString()));
    }
  }
}

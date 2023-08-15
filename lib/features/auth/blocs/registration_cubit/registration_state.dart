// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'registration_cubit.dart';

abstract class RegistrationState extends Equatable {
  @override
  List<Object> get props => [];
}

 class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}


class RegisterSucess extends RegistrationState {
  final String message;
  RegisterSucess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class RegisterFailure extends RegistrationState {
  final String message;
  RegisterFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}


class RegisterLoading extends RegistrationState {

  RegisterLoading(
 
  );

  @override
  List<Object> get props => [];
}

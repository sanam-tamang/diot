// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'logout_cubit.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutSuccess extends LogoutState {
  final  String message;
 const  LogoutSuccess({
    required this.message,
  });

    @override
  List<Object> get props => [message];
}

class LogoutFailure extends LogoutState {
 final  String message;
 const  LogoutFailure({
    required this.message,
  });

    @override
  List<Object> get props => [message];
}

class LogoutLoading extends LogoutState {}


part of 'signin_cubit.dart';
abstract class SigninState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninSuccess extends SigninState {}

class SigninFailure extends SigninState {
  final String errorMessage;

  SigninFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

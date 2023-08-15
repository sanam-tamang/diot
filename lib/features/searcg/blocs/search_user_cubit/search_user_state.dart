part of 'search_user_cubit.dart';

sealed class SearchUserState extends Equatable {
  const SearchUserState();

  @override
  List<Object?> get props => [];
}

final class SearchUserInitial extends SearchUserState {}

final class SearchUserLoading extends SearchUserState {}

final class SearchUserLoaded extends SearchUserState {
  final List<User>? users;

  const SearchUserLoaded({required this.users});

  @override
  List<Object?> get props => [users];
}

final class SearchUserFailure extends SearchUserState {
  final String message;

  const SearchUserFailure({required this.message});

    @override
  List<Object?> get props => [];
}

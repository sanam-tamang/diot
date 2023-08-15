// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'collection_user_du_cubit.dart';

abstract class CollectionUserDuState extends Equatable {
  const CollectionUserDuState();

  @override
  List<Object> get props => [];
}

class CollectionUserDuInitial extends CollectionUserDuState {}

class CollectionUserDuLoading extends CollectionUserDuState {}

class CollectionUserDuSuccess extends CollectionUserDuState {}

class CollectionUserDuFailure extends CollectionUserDuState {
  final String message;
 const  CollectionUserDuFailure({
    required this.message,
  });

    @override
  List<Object> get props => [message];
}

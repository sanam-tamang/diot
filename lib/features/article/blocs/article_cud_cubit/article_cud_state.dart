// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'article_cud_cubit.dart';

abstract class ArticleCudState extends Equatable {
  const ArticleCudState();

  @override
  List<Object> get props => [];
}

class ArticleCudInitial extends ArticleCudState {}

class ArticleCudSuccess extends ArticleCudState {
  final String message;
 const  ArticleCudSuccess({
    required this.message,
  });
    @override
  List<Object> get props => [message];
}

class ArticleCudLoading extends ArticleCudState {}

class ArticleCudFailure extends ArticleCudState {
  final String message;
 const  ArticleCudFailure({
    required this.message,
  });
    @override
  List<Object> get props => [message];

}

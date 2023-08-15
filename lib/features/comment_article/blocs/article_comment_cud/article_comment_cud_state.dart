// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'article_comment_cud_cubit.dart';

abstract class ArticleCommentCudState extends Equatable {
  const ArticleCommentCudState();

  @override
  List<Object> get props => [];
}

class ArticleCommentCudInitial extends ArticleCommentCudState {}

class ArticleCommentCudLoading extends ArticleCommentCudState {}

class ArticleCommentCudSuccess extends ArticleCommentCudState {
  final String message;
  const ArticleCommentCudSuccess({
    required this.message,
  });


  @override
  List<Object> get props => [message];
}

class ArticleCommentCudFailure extends ArticleCommentCudState {
    final String message;
  const ArticleCommentCudFailure({
    required this.message,
  });


  @override
  List<Object> get props => [message];
}

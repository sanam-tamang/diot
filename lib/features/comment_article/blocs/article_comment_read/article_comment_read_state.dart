part of 'article_comment_read_cubit.dart';

abstract class ArticleCommentReadState extends Equatable {
  const ArticleCommentReadState();

  @override
  List<Object> get props => [];
}

class ArticleCommentReadInitial extends ArticleCommentReadState {}

class ArticleCommentReadLoading extends ArticleCommentReadState {}

class ArticleCommentReadLoaded extends ArticleCommentReadState {
  final List<GetComment?> comments;

  const ArticleCommentReadLoaded({required this.comments});

  @override
  List<Object> get props => [comments];
}

 class ArticleCommentReadFailure extends ArticleCommentReadState {
  final String message;

  const ArticleCommentReadFailure({required this.message});

  @override
  List<Object> get props => [message];
}

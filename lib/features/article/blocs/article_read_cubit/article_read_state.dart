// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'article_read_cubit.dart';

abstract class ArticleReadState extends Equatable {
  const ArticleReadState();

  @override
  List<Object> get props => [];
}

class ArticleReadInitial extends ArticleReadState {}

class ArticleReadLoading extends ArticleReadState {}

class ArticleReadLoaded extends ArticleReadState {
  final List<GetArticle> article;
  const ArticleReadLoaded({
    required this.article,
  });

  @override
  List<Object> get props => [];
}

class ArticleReadFailure extends ArticleReadState {
  final String message;
 const  ArticleReadFailure({
    required this.message,
  });

   @override
  List<Object> get props => [message];
}

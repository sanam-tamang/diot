// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'article_like_cubit.dart';

abstract class ArticleLikeState extends Equatable {
  const ArticleLikeState();

  @override
  List<Object> get props => [];
}

class ArticleLikeInitial extends ArticleLikeState {}

class ArticleLikeLoading extends ArticleLikeState {}

class ArticleLikeLoaded extends ArticleLikeState {
 
  //it will help to store the data until we don't get data from the server
  final GetArticle article;
  const ArticleLikeLoaded({
    
    required this.article,
  });

  @override
  List<Object> get props => [article];
}

class ArticleLikeFailure extends ArticleLikeState {}

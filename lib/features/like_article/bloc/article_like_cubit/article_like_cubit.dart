import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../article/models/article.dart';
import '../../repositories/like_repository.dart';

part 'article_like_state.dart';

///this article like cubit will help to change the
///
///like count of the article and show the locally changed
///
/// data of the article if new updated data is not being fetch
///
///Updated data is being fetch by the **** [ArticleReadCubit]
///
///and after fetching the article this [ArticleLikeCubit] will be set to
///
///[ArticleLikeInitial] fromt the [ArticleReadCubit] to show the updated article data
///
class ArticleLikeCubit extends Cubit<ArticleLikeState> {
  ArticleLikeCubit() : super(ArticleLikeInitial());

  Future<void> likeArticle({required GetArticle article}) async {
    int totalCount = article.likeCount;
    emit(ArticleLikeLoading());
    try {
      if (article.isLiked && article.likeCount > 0) {
        totalCount--;
        //removing like if it has already been liked
        await LikeRepository.instance.likeArticle(articleId: article.id);

        ///it will show the data locally to fast user experience
        emit(ArticleLikeLoaded(
          article: article.copyWith(likeCount: totalCount, isLiked: false),
        ));
      } else if (!article.isLiked ) {
        totalCount++;
        //adding like if it has not already been liked
        await LikeRepository.instance.likeArticle(articleId: article.id);

        ///it will show the data locally to fast user experience
        emit(ArticleLikeLoaded(
          article: article.copyWith(likeCount: totalCount, isLiked: true),
        ));
      }
    } catch (e) {
      emit(ArticleLikeFailure());
    }
  }

  ///set to initial state when [ArticleReadCubit] fetch new data
  void setToInitialState() {
    emit(ArticleLikeInitial());
  }
}

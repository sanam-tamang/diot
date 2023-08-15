import '../../../article/repositories/article_repositoritories.dart';
import '../../model/comment_model.dart';
import '../../repository/comment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'article_comment_cud_state.dart';

///article comment for create update and delete [CUD]
class ArticleCommentCudCubit extends Cubit<ArticleCommentCudState> {
  ArticleCommentCudCubit() : super(ArticleCommentCudInitial());

  Future<void> createArticleComment(CreateComment comment) async {
    emit(ArticleCommentCudLoading());
    try {
     
      await Future.wait([
          CommentRepository.instance.addComment(comment),
          ArticleRepositories.instance
          .incrementArticleCommentCount(articleId: comment.articleId)
      ]);
      emit(const ArticleCommentCudSuccess(message: "Commented"));
    } catch (e) {
      emit(ArticleCommentCudFailure(message: e.toString()));
    }
  }
}

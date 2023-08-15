import 'dart:async';

import '../../model/comment_model.dart';
import '../../repository/comment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'article_comment_read_state.dart';

class ArticleCommentReadCubit extends Cubit<ArticleCommentReadState> {
  ArticleCommentReadCubit() : super(ArticleCommentReadInitial());
  late StreamSubscription _streamSubscription;
  void getArticleComments({required String articleId}) {
    try {
      emit(ArticleCommentReadLoading());
      _streamSubscription =
          CommentRepository.instance.getComments(articleId).listen((comments) {
        emit(ArticleCommentReadLoaded(comments: comments));
      });
    } catch (e) {
      emit(ArticleCommentReadFailure(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}

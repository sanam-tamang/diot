import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/article.dart';
import 'package:equatable/equatable.dart';

import '../../../like_article/bloc/article_like_cubit/article_like_cubit.dart';
import '../../repositories/article_repositoritories.dart';

part 'article_read_state.dart';

class ArticleReadCubit extends Cubit<ArticleReadState> {
  late StreamSubscription<List<GetArticle>> _articleReader;
  final ArticleLikeCubit _articleLikeCubit;
  ArticleReadCubit({required ArticleLikeCubit articleLikeCubit})
      : _articleLikeCubit = articleLikeCubit,
        super(ArticleReadInitial()){
           _articleReader = _repositories.getArticles().listen((articles) {
      _readArticle(articles);
    });
        }

  final ArticleRepositories _repositories = ArticleRepositories.instance;

  void _readArticle(List<GetArticle> articles) {
    emit(ArticleReadLoading());
    try {
      emit(ArticleReadLoaded(article: articles));

      ///setting to initial state to remove that locally showed liked data
      ///after got data from the server
      ///
      _articleLikeCubit.setToInitialState();
    } catch (e) {
      emit(const ArticleReadFailure(message: ""));
    }
  }



  @override
  Future<void> close() {
    _articleReader.cancel();
    return super.close();
  }
}

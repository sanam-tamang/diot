// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:devmandu/features/article/models/article.dart';
import 'package:devmandu/features/article/repositories/article_repositoritories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'article_cud_state.dart';

///article create update and delete operation perform here
class ArticleCudCubit extends Cubit<ArticleCudState> {
  ArticleCudCubit():
      
        super(ArticleCudInitial());
  final ArticleRepositories _repositories = ArticleRepositories.instance;

  Future<void> create(CreateArticle article) async {
    emit(ArticleCudLoading());
    try {
      await _repositories.createArticle(article);
      emit(const ArticleCudSuccess(message: 'Article created'));
   
    } catch (e) {
      log(e.toString());
      emit(const ArticleCudFailure(message: 'Something went wrong!'));
    }
  }

  Future<void> updateArticle(String articleId, {required CreateArticle article})async {
      emit(ArticleCudLoading());
    try {
      await _repositories.updateArticle(articleId,article: article);
      emit(const ArticleCudSuccess(message: 'Article updated'));
   
    } catch (e) {
      log(e.toString());
      emit(const ArticleCudFailure(message: 'Something went wrong!'));
    }
  }

  Future<void> deleteArticle(GetArticle article)async {
     emit(ArticleCudLoading());
    try {
      await _repositories.deleteArticle(article: article);
      emit(const ArticleCudSuccess(message: 'Article deleted'));
   
    } catch (e) {
      log(e.toString());
      emit( ArticleCudFailure(message: e.toString()));
    }
  }
}

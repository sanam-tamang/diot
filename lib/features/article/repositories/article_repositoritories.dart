import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devmandu/core/repositories/image_uploader_repository.dart';
import 'package:devmandu/features/profile/repositories/user_collection_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../like_article/repositories/like_repository.dart';
import '../models/article.dart';

class ArticleRepositories {
  ArticleRepositories._();
  static final ArticleRepositories instance = ArticleRepositories._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> createArticle(CreateArticle article) async {
    final byte = article.imageFile;

    _firestore.collection('article').add({
      "userId": _auth.currentUser?.uid ?? (throw "User must login"),
      "title": article.title,
      "content": article.content,
      "timestamp": FieldValue.serverTimestamp(),
      "totalLikeCount": 0,
      "totalCommentCount": 0,
      "image": byte == null
          ? null
          : await ImageUploaderRepository.getInstance().uploadToFirebase(byte),
    });
  }

  ///if [userId] is provided filter data by that Id,
  Stream<List<GetArticle>> getArticles({
    String? userId,
  }) {
    Query query = _firestore.collection('article');

    if (userId != null) {
      query = query.where("userId", isEqualTo: userId);
    }

    query = query.orderBy("timestamp", descending: true);

    return query.snapshots().asyncMap((querySnapshot) async {
      final articles = await Future.wait(querySnapshot.docs.map((doc) async {
        final articleId = doc.id;
        final articleMap = doc.data() as Map<String, dynamic>;
        final user = await UserCollectionRepository.getInstance()
            .getUser(articleMap['userId']);
        final isLikedByCurrentLoginUser = await LikeRepository.instance
            .isArticleLikedByUser(articleId: articleId);
        final Timestamp timestamp = articleMap['timestamp'] ?? Timestamp.now();
        final article = GetArticle(
          id: articleId,
          title: articleMap['title'] ?? "",
          content: articleMap['content'] ?? "",
          image: articleMap['image'],
          isLiked: isLikedByCurrentLoginUser,
          user: user!,
          date: timestamp.toDate(),
          likeCount: articleMap["totalLikeCount"] ?? 0,
          commentCount: articleMap['totalCommentCount'] ?? 0,
        );

        log("*******article one  ${article.title}");
        log("*******article content  ${article.content}");
        log("#########################");

        return article;
      }));

      return articles;
    });
  }

  Future<void> deleteArticle({required GetArticle article}) async {
    await _firestore.collection('article').doc(article.id).delete();
  }

  ///like value is either -1 or 1 if -1 there decrement the like value meaning that user has
  ///unlike the article post and if +1 then increment the value
  Future<void> updateArticleLikeCount(
      {required String articleId, required int likeValue}) async {
    try {
      await _firestore.collection('article').doc(articleId).update({
        "totalLikeCount": FieldValue.increment(likeValue),
      });
    } catch (e) {
      log(e.toString());
      throw 'Server error';
    }
  }

  Future<void> incrementArticleCommentCount({required String articleId}) async {
    try {
      await _firestore.collection('article').doc(articleId).update({
        "totalCommentCount": FieldValue.increment(1),
      });
    } catch (e) {
      log(e.toString());
      throw 'Server error';
    }
  }

  Future<void> updateArticle(String articleId,{required CreateArticle article}) async {
   
   await  _firestore.collection('article').doc(articleId).update({
    
      "title": article.title,
      "content": article.content,
     
    });
  }
}

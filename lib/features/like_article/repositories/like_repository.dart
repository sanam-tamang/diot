import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../article/repositories/article_repositoritories.dart';

class LikeRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  LikeRepository._();
  static LikeRepository get instance => LikeRepository._();

  Future<bool> isArticleLikedByUser({required String articleId}) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      return Future.value(false);
    }

    final likeRef = await _firestore
        .collection('user')
        .doc(userId)
        .collection('like')
        .doc(articleId)
        .get();
    return likeRef.exists;
  }

  Future<void> likeArticle({required String articleId}) async {
     await isArticleLikedByUser(articleId: articleId)
        ? _removeLike(articleId: articleId)
        : _addLike(articleId: articleId);
  }

  Future<void> _addLike({required String articleId}) async {
    final likeRef = _firestore
        .collection('user')
        .doc(_auth.currentUser?.uid)
        .collection('like');

    // add like
    Future.wait([
      likeRef
          .doc(articleId)
          .set({'articleId': articleId, 'timeStamp': Timestamp.now()}),
      ArticleRepositories.instance
          .updateArticleLikeCount(articleId: articleId, likeValue: 1),
    ]);
  }

  Future<void> _removeLike({required String articleId}) async {
    //remove like
    final likeRef = _firestore
        .collection('user')
        .doc(_auth.currentUser?.uid)
        .collection('like');
    Future.wait([
      ArticleRepositories.instance
          .updateArticleLikeCount(articleId: articleId, likeValue: -1),
      likeRef.doc(articleId).delete(),
    ]);
  }
}

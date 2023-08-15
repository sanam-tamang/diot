import 'package:cloud_firestore/cloud_firestore.dart';

import '../../like_article/repositories/like_repository.dart';
import '../models/like_comment_count_model.dart';

///this repository will be used to counting the number of like and comments and check whether it has been liked or not
///by the current user in {detail page only} to update realtime data
class LikeCommentCountRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  LikeCommentCountRepository._();
  static LikeCommentCountRepository get instance =>
      LikeCommentCountRepository._();
  Stream<LikeCommentCountModel> getLikeCommentCount(
      {required String articleId}) async* {
    final snapshot =
        _firestore.collection('article').doc(articleId).snapshots();
    yield* snapshot.asyncMap((query) async {
      final data = query.data() as Map<String, dynamic>;
      final isLikedByCurrentLoginUser = await LikeRepository.instance
          .isArticleLikedByUser(articleId: articleId);
      return LikeCommentCountModel(
          isLiked: isLikedByCurrentLoginUser,
          likeCount: data["totalLikeCount"] ?? 0,
          commentCount: data['totalCommentCount'] ?? 0);
    });
  }
}

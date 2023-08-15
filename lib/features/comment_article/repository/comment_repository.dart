import 'package:cloud_firestore/cloud_firestore.dart';
import '../../profile/repositories/user_collection_repository.dart';
import '../model/comment_model.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CommentRepository {
  CommentRepository._();
  static CommentRepository get instance => CommentRepository._();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addComment(CreateComment comment) async {
    try {
      await _firestore
          .collection('article')
          .doc(comment.articleId)
          .collection('comment')
          .doc(comment.commentId)
          .set(comment.copyWith(userId: _auth.currentUser?.uid).toMap());
    } catch (e) {
      throw "Something went wrong!";
    }
  }

  Stream<List<GetComment?>> getComments(String articleId) {
    try {
      final snapshot = _firestore
          .collection('article')
          .doc(articleId)
          .collection('comment').orderBy("timestamp",descending: true)
          .snapshots();

      return snapshot.asyncMap((querySnapshot) {
        return Future.wait(querySnapshot.docs.map((doc) async{
          final data = doc.data();
          final Timestamp timestamp = data['timestamp'];

          final user = await UserCollectionRepository.getInstance().getUser(data['user']);
          return user==null?null: GetComment(commentId: data['commentId'], content: data['content'], user:user, dateTime: timestamp.toDate() );
        }));
      });
    } catch (e) {
      throw "Something went wrong!";
    }
  }
}

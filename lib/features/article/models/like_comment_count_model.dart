// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LikeCommentCountModel extends Equatable {
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  const LikeCommentCountModel({
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
  });
  @override
  List<Object> get props => [likeCount, commentCount, isLiked];
}

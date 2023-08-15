// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../core/model/user.dart';

class CreateComment extends Equatable {
  final String articleId;
  final String commentId;
  final String? userId;
  final String content;
  final Timestamp timestamp;
  const CreateComment({
    required this.articleId,
    required this.commentId,
    this.userId,
    required this.content,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [articleId, commentId, userId, content];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentId': commentId,
      'articleId': articleId,
      'user': userId,
      'content': content,
      'timestamp': timestamp
    };
  }

  CreateComment copyWith({
    String? articleId,
    String? userId,
    String? content,
  }) {
    return CreateComment(
      articleId: articleId ?? this.articleId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      commentId: commentId, timestamp: timestamp,
    );
  }
}

class GetComment extends Equatable {
  final String commentId;
  final User user;
  final String content;
  final DateTime dateTime;
  const GetComment({
    required this.commentId,
    required this.user,
    required this.content,
    required this.dateTime,
  });

  @override
  List<Object> get props => [commentId, user, content];
}

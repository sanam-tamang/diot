
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../../../core/model/user.dart';

class CreateArticle extends Equatable {
  final String title;
  final String content;
  final Uint8List? imageFile;

  const CreateArticle({
    required this.title,
    required this.content,
    this.imageFile,
  });

  @override
  List<Object?> get props => [title, content, imageFile];
}

class GetArticle extends Equatable {
  final String id;
  final String? title;
  final String? content;
  final String? image;
  final User user;
  final DateTime date;
  final int likeCount;
  final int commentCount;
  ///whether the current login user liked the post or not
  final bool isLiked;

  const GetArticle({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    required this.user,
    required this.date,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      content,
      image,
      user,
      date,
      likeCount,
      commentCount,
      isLiked,
    ];
  }

  GetArticle copyWith({

    String? title,
    String? content,
    String? image,
    User? user,
    int? likeCount,
    bool? isLiked,
    int? commentCount
  }) {
    return GetArticle(
      id: id ,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      user: user ?? this.user,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked, date: date, commentCount:commentCount??this.commentCount ,
    );
  }
}

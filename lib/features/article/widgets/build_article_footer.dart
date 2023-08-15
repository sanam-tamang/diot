

import '../../../core/config/size.dart';
import '../../../core/config/theme/app_colors.dart';
import '../models/article.dart';
import '../models/like_comment_count_model.dart';
import '../repositories/like_comment_stream_count_in_detail_repository.dart';
import '../../comment_article/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../comment_article/widgets/comment_button.dart';
import '../../like_article/bloc/article_like_cubit/article_like_cubit.dart';
import '../../like_article/widgets/like_button.dart';

class BuildArticleFooter extends StatefulWidget {
  const BuildArticleFooter({
    Key? key,
    required this.article,
    this.isDetailPage = false,
  }) : super(key: key);
  final GetArticle article;
  final bool isDetailPage;

  @override
  State<BuildArticleFooter> createState() => BuildArticleFooterState();
}

class BuildArticleFooterState extends State<BuildArticleFooter> {
  @override
  Widget build(BuildContext context) {
    var detailInteractionBuilder = StreamBuilder<LikeCommentCountModel>(
        stream: LikeCommentCountRepository.instance
            .getLikeCommentCount(articleId: widget.article.id),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data != null) {
            return __buildThreeActions(
              commentCount: data.commentCount,
              likeButton: LikeButton(
                likeCount: data.likeCount,
                onPressed: __likeArticle,
                isLiked: data.isLiked,
              ),
            );
          } else {
            return const SizedBox();
          }
        });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4)
          .copyWith(bottom: 6),
      child: !widget.isDetailPage
          ? _buildNormalFooterWidget()
          : detailInteractionBuilder,
    );
  }

  BlocBuilder<ArticleLikeCubit, ArticleLikeState> _buildNormalFooterWidget() {
    return BlocBuilder<ArticleLikeCubit, ArticleLikeState>(
      builder: (context, state) {
        if (state is ArticleLikeLoaded &&
            state.article.id == widget.article.id) {
          ///it will show the local update local update ,
          return __buildThreeActions(
              commentCount: widget.article.commentCount,
              likeButton: LikeButton(
                  onPressed: null,
                  isLiked: state.article.isLiked,
                  likeCount: state.article.likeCount));
        } else {
          ///it will show server update
          return __buildThreeActions(
            commentCount: widget.article.commentCount,
            likeButton: LikeButton(
              likeCount: widget.article.likeCount,
              onPressed: __likeArticle,
              isLiked: widget.article.isLiked,
            ),
          );
        }
      },
    );
  }

  Widget __buildThreeActions(
      {required Widget likeButton, required int commentCount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          likeButton,
          CommentButton(
            onPressed: widget.isDetailPage ? null : _commentArticle,
            commentCount: commentCount,
          ),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.shareNodes,
              color: AppColors.articleFooterActionsDefaultColor,
              size: footerArticleIconSize,
            ),
          )
        ],
      ),
    );
  }

  void __likeArticle() {
    context.read<ArticleLikeCubit>().likeArticle(article: widget.article);
  }

  Future<void> _commentArticle() async {
    
      await showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: CommentWidget(
                  article: widget.article,
                  autoFocusCommentField: true,
                  pop: true,
                ));
          });
    
  }
}

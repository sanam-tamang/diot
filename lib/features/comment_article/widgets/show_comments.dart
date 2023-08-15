import '../../../core/enum/loading_type.dart';
import '../../../core/extenstions/time_ago.dart';
import '../../../core/widgets/build_avatar_image.dart';
import '../../../core/widgets/read_more.dart';
import '../../profile/blocs/collection_user_cubit/collection_user_cubit.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_circular_progress_widget.dart';
import 'package:devmandu/core/widgets/custom_error_message_widget.dart';
import 'package:devmandu/features/comment_article/model/comment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/route/route_name.dart';
import '../../../core/config/theme/app_colors.dart';
import '../blocs/article_comment_read/article_comment_read_cubit.dart';

class ShowComments extends StatefulWidget {
  const ShowComments({
    Key? key,
    required this.articleId,
  }) : super(key: key);
  final String articleId;

  @override
  State<ShowComments> createState() => _ShowCommentsState();
}

class _ShowCommentsState extends State<ShowComments> {
  @override
  void initState() {
    context
        .read<ArticleCommentReadCubit>()
        .getArticleComments(articleId: widget.articleId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ArticleCommentReadCubit, ArticleCommentReadState>(
      builder: (context, state) {
        if (state is ArticleCommentReadLoading) {
          return const CustomCircularProgressIndicator(
            type: LoadingType.comment,
          );
        } else if (state is ArticleCommentReadLoaded) {
          return _BuildComments(comments: state.comments);
        } else if (state is ArticleCommentReadFailure) {
          return CustomErrorMessageWidget(message: state.message);
        }
        return const SizedBox.shrink();
      },
    ));
  }
}

class _BuildComments extends StatefulWidget {
  const _BuildComments({
    Key? key,
    required this.comments,
  }) : super(key: key);
  final List<GetComment?> comments;

  @override
  State<_BuildComments> createState() => _BuildCommentsState();
}

class _BuildCommentsState extends State<_BuildComments> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 15,
          );
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.comments.length,
        itemBuilder: (context, index) {
          final comment = widget.comments[index];
          return comment==null?const SizedBox.shrink(): Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
                color: AppColors.greyScale8,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.2),
                      blurRadius: 40,
                      spreadRadius: 0,
                      offset: const Offset(-5, 5))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    userImageProfile(comment),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _username(comment, context),
                              const SizedBox(
                                width: 10,
                              ),
                              _publishedTime(comment, context),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                _commentContent(comment, context),
              ],
            ),
          );
        });
  }

  Column userImageProfile(GetComment comment) {
    return Column(
      children: [
        ///this will help to navigate properly if profile is loaded then we check whether
        ///user want to navigate to there only profile or not
        BlocBuilder<CollectionUserCubit, CollectionUserState>(
          builder: (context, state) {
            if (state is CollectionUserLoaded) {
              return GestureDetector(
                  onTap: () => state.user.userId == comment.user.userId
                      ? null
                      : _gotoProfile(comment.user.userId),
                  child: _buildAvatar(comment));
            }
            return GestureDetector(
              onTap: () => _gotoProfile(comment.user.userId),
              child: _buildAvatar(comment),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildAvatar(GetComment comment) {
    return BuildAvatarImageNetwork(
      image: comment.user.image,
      radius: 25,
    );
  }

  Widget _commentContent(GetComment comment, BuildContext context) {
    return CustomReadMore(
      comment.content,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  Flexible _publishedTime(GetComment comment, BuildContext context) {
    return Flexible(
      child: Text(
        ".${comment.dateTime.timeAgo()}",
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  Flexible _username(GetComment comment, BuildContext context) {
    return Flexible(
      child: Text(
        comment.user.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  void _gotoProfile(String userId) {
    Navigator.of(context)
        .pushNamed(AppRouteName.profile, arguments: {'userId': userId});
  }
}

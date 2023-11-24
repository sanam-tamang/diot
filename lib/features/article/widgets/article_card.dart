import '../../../core/widgets/text_with_icon.dart';
import '../blocs/article_cud_cubit/article_cud_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/route/route_name.dart';
import '../../../core/enum/hero_tag_type.dart';
import '../../../core/extenstions/time_ago.dart';
import '../../../core/widgets/hero_widget.dart';
import 'quill_read_only_editor.dart';
import '../../profile/blocs/collection_user_cubit/collection_user_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/widgets/build_avatar_image.dart';
import '../../../core/enum/article_pop_menu_type.dart';

import '../models/article.dart';
import 'build_article_footer.dart';
import 'image_manupulated_cached_image.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard(
      {super.key,
      required this.article,
      this.isDetailPage = false,
      this.items = const []});

  final GetArticle article;
  final List<PopupMenuItem<dynamic>> items;

  ///if detail page is true then gotoDetail page won't happen
  ///and show all the content of text which is hidden
  final bool isDetailPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 2, left: 2, right: 2),
      decoration: BoxDecoration(
          color: AppColors.articleBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.25),
                blurRadius: 100,
                spreadRadius: -5,
                offset: const Offset(0, 0))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BuildArticleHeader(
            article: article,
            items: items,
          ),
          _BuildArticleBody(
            article: article,
            isDetailPage: isDetailPage,
          ),
          BuildArticleFooter(
            article: article,
            isDetailPage: isDetailPage,
          ),
        ],
      ),
    );
  }
}

class _BuildArticleHeader extends StatelessWidget {
  final GetArticle article;
  final List<PopupMenuItem> items;
  const _BuildArticleHeader({
    required this.article,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<CollectionUserCubit, CollectionUserState>(
          builder: (context, state) {
            if (state is CollectionUserLoaded) {
              return GestureDetector(
                onTap: () => state.user.userId == article.user.userId
                    ? null
                    : _gotoProfile(context),
                child: BuildAvatarImageNetwork(
                  image: article.user.image,
                ),
              );
            }
            return GestureDetector(
              onTap: () => _gotoProfile(context),
              child: BuildAvatarImageNetwork(
                image: article.user.image,
              ),
            );
          },
        ),
        Flexible(
          flex: 3,
          child: ListTile(
            title: Text(
              article.user.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(article.date.timeAgo(numericDates: true)),
          ),
        ),
        const Spacer(),
        Tooltip(message: 'more vert', child: _moreVertButton(context)),
      ],
    );
  
  
  }

  PopupMenuButton<dynamic> _moreVertButton(BuildContext context) {
    return PopupMenuButton(
        onSelected: (dynamic type) {
          switch (type) {
            case ArticlePopMenuType.share:
              break;
            case ArticlePopMenuType.delete:
              context.read<ArticleCudCubit>().deleteArticle(article);
              break;
            case ArticlePopMenuType.update:
              Navigator.of(context).pushNamed(AppRouteName.updateArticle,
                  arguments: {'article': article});
              break;
            default:
              break;
          }
        },
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: ArticlePopMenuType.share,
              child: TextWithIcon(
                icon: FontAwesomeIcons.shareNodes,
                text: "share",
              ),
            ),
            ...items,
          ];
        },
        icon: const Icon(Icons.more_vert));
  }

  void _gotoProfile(BuildContext context) {
    Navigator.of(context).pushNamed(AppRouteName.profile,
        arguments: {'userId': article.user.userId});
  }
}

class _BuildArticleBody extends StatelessWidget {
  final GetArticle article;
  final bool isDetailPage;
  const _BuildArticleBody({
    required this.article,
    required this.isDetailPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isDetailPage ? null : _gotoArticleDetailPage(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () => isDetailPage
                  ? article.image == null
                      ? null
                      : _gotoInteractiveViewer(context)
                  : _gotoArticleDetailPage(context),
              child: CustomHeroWidget(
                  tag: article.image == null
                      ? HeroTagType.noAnimation
                      : HeroTagType.article,
                  payload: article.image ?? "",
                  child:
                      ManupulatedCachedNetworkImage(imageUrl: article.image))),
          article.title == null || article.title == ""
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    article.title!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                ),

          ///if empty then it comes as
          ///'[{"insert":"\n"}]'
          article.content == '[{"insert":"\\n"}]'
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: QuillReadonlyEditor(
                    originalContent: article.content!,
                    maxLines: isDetailPage
                        ? null
                        : article.image == null
                            ? 6
                            : 2,
                  ),
                )
        ],
      ),
    );
  }

  void _gotoArticleDetailPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRouteName.articleDetailPage,
        arguments: {"article": article});
  }

  void _gotoInteractiveViewer(BuildContext context) {
    Navigator.of(context).pushNamed(AppRouteName.interactiveViewImage,
        arguments: {"imageUrl": article.image, "tag": HeroTagType.article});
  }
}

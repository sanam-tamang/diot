import 'package:flutter/material.dart';

import '../../../core/config/size.dart';
import '../../article/widgets/article_card.dart';
import '../models/article.dart';

class BuildArticles extends StatelessWidget {
  const BuildArticles({
    super.key,
    required this.articles,
  });
  final List<GetArticle> articles;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.10),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: articleGap,
                );
              },
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ArticleCard(article: article);
              })
        ],
      ),
    );
  }
}

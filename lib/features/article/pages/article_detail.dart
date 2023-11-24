
import '../../comment_article/widgets/comment_widget.dart';
import '../../comment_article/widgets/show_comments.dart';
import 'package:flutter/material.dart';

import '../models/article.dart';

import '../widgets/article_card.dart';

class ArticleDetailPage extends StatefulWidget {
  const ArticleDetailPage({
    super.key,
    required this.article,
  });
  final GetArticle article;
  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  late GetArticle article;
  @override
  void initState() {
    article = widget.article;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Article"),),
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverToBoxAdapter(
          child: ArticleCard(
            article: article,
            isDetailPage: true,
            items: const [],
          ),
        ),
        SliverToBoxAdapter(
          child: CommentWidget(
            article: article,
          ),
        ),
        SliverToBoxAdapter(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ShowComments(articleId: article.id)))
      ]),
    );
  }
}

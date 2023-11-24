import '../../../core/config/size.dart';
import '../../../core/widgets/annoted_region.dart';
import '../../navbar/blocs/change_navbar_index_cubit/change_navbar_indexer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/custom_circular_progress_widget.dart';
import '../../article/widgets/article_card.dart';

import '../../article/blocs/article_read_cubit/article_read_cubit.dart';
import '../../article/models/article.dart';
import '../widgets/search_box.dart';

class SearchArticlePage extends StatefulWidget {
  const SearchArticlePage({super.key});

  @override
  State<SearchArticlePage> createState() => _SearchArticlePageState();
}

class _SearchArticlePageState extends State<SearchArticlePage> {
  late TextEditingController _filterController;
  late final FocusNode _filterControllerFocusNode;
  @override
  void initState() {
    _filterController = TextEditingController();
    _filterControllerFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _filterController.dispose();
    _filterControllerFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeNavbarIndexerCubit, ChangeNavbarIndexerState>(
      listener: (context, state) {
        //disabling the textfield focus if otherthatn index 2 meaning that position [3 add button]
        if (state.index != 2) {
          _filterControllerFocusNode.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: CustomAnnotatedRegion(
          color: Colors.grey.shade200,
          child: SafeArea(
            child: Column(
              children: [
                _searchBar(),
                Expanded(
                  child: BlocBuilder<ArticleReadCubit, ArticleReadState>(
                    builder: (context, state) {
                      if (state is ArticleReadLoading ||
                          state is ArticleReadInitial) {
                        return const CustomCircularProgressIndicator();
                      } else if (state is ArticleReadFailure) {
                        return const Text("Something went wrong");
                      } else if (state is ArticleReadLoaded) {
                        return _BuildArticleFilteredList(
                          filterController: _filterController,
                          articles: state.article,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return SearchBox(
        controller: _filterController,
        hintText: "Search article",
        focusNode: _filterControllerFocusNode,
        onSubmit: () {
          setState(() {});
        },
        onChanged: (va) {
          setState(() {});
        });
  }
}

class _BuildArticleFilteredList extends StatelessWidget {
  const _BuildArticleFilteredList({
    required this.filterController,
    required this.articles,
  });

  final TextEditingController filterController;
  final List<GetArticle> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        final article = articles[index];
        final title = article.title ?? "";
        bool isContainTitle =
            title.toLowerCase().contains(filterController.text.toLowerCase());
        bool isContainUserName = article.user.name
            .toLowerCase()
            .contains(filterController.text.toLowerCase());
        bool isNameContains = isContainTitle || isContainUserName;
        if (isNameContains && filterController.text.isNotEmpty) {
          return const SizedBox(
            height: articleGap,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        final title = article.title ?? "";

        bool isContainTitle =
            title.toLowerCase().contains(filterController.text.toLowerCase());
        bool isContainUserName = article.user.name
            .toLowerCase()
            .contains(filterController.text.toLowerCase());
        bool isNameContains = isContainTitle || isContainUserName;
        if (isNameContains && filterController.text.isNotEmpty) {
          return ArticleCard(article: articles[index]);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

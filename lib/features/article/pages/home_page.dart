

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/custom_circular_progress_widget.dart';
import '../blocs/article_read_cubit/article_read_cubit.dart';

import '../../../core/enum/loading_type.dart';
import '../../../core/widgets/app_logo.dart';
import '../widgets/build_articles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  AppLogo(),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [];
        },
        body: BlocBuilder<ArticleReadCubit, ArticleReadState>(
          builder: (context, state) {
            if (state is ArticleReadLoading || state is ArticleReadInitial) {
              return const CustomCircularProgressIndicator(
                type: LoadingType.article,
              );
            } else if (state is ArticleReadFailure) {
              return Text(state.message);
            } else if (state is ArticleReadLoaded) {
              return BuildArticles(articles: state.article);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

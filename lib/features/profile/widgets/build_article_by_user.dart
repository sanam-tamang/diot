import 'dart:developer';

import '../../../core/config/size.dart';
import '../../../core/config/theme/app_colors.dart';
import 'package:devmandu/core/enum/article_pop_menu_type.dart';
import 'package:devmandu/core/enum/loading_type.dart';
import 'package:devmandu/core/widgets/no_article_widget.dart';
import 'package:devmandu/core/widgets/text_with_icon.dart';
import 'package:devmandu/features/article/models/article.dart';
import 'package:devmandu/features/auth/repositories/user_repository.dart';
import 'package:flutter/material.dart';

import '../../../core/model/user.dart';
import '../../../core/widgets/custom_circular_progress_widget.dart';
import '../../article/repositories/article_repositoritories.dart';
import '../../article/widgets/article_card.dart';

class BuildArticlesByUser extends StatefulWidget {
  const BuildArticlesByUser({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<BuildArticlesByUser> createState() => _BuildArticlesByUserState();
}

class _BuildArticlesByUserState extends State<BuildArticlesByUser> {
  
  @override
  void initState() {
   
    super.initState();
  }

  @override
  void dispose() {
    // _articleCudCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
             width: double.maxFinite,
             padding: const EdgeInsets.all(12),
             decoration: decoration(context),
             child: Text(
               "Articles",
               style: Theme.of(context)
                   .textTheme
                   .displaySmall
                   ?.copyWith(fontSize: 24),
             ),
           ),
           const SizedBox(
             height: 12,
           ),
           StreamBuilder(
               stream: ArticleRepositories.instance
                   .getArticles(userId: widget.user.userId),
               builder: (context, snapshot) {
                 log("User nspshot ${snapshot.runtimeType}");
                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return SizedBox(
                     height: MediaQuery.of(context).size.height * 0.8,
                     child: const CustomCircularProgressIndicator(
                       type: LoadingType.article,
                     ),
                   );
                 } else if (snapshot.hasData) {
                   log("I am /////////");
                   final data = snapshot.data;
                   log(data.toString());

                   return data!.isNotEmpty
                       ? ListView.separated(
                           separatorBuilder: (context, index) {
                             return const SizedBox(
                               height: articleGap,
                             );
                           },
                           physics: const NeverScrollableScrollPhysics(),
                           shrinkWrap: true,
                           itemCount: data.length,
                           itemBuilder: (context, index) {
                             return ArticleCard(
                               article: data[index],
                               items: UserRepository.getInstance()
                                           .currentUser
                                           ?.uid ==
                                       widget.user.userId
                                   ? _loginUserRoleFunctions(
                                       article: data[index],
                                     
                                            
                                       
                                       )
                                   : [],
                             );
                           })
                       : const SizedBox(
                           height: 400, child: NoArticleMessage());
                 } else {
                   return const SizedBox.shrink();
                 }
               }),
         ],
       ),
     );
  }

  List<PopupMenuItem<dynamic>> _loginUserRoleFunctions(
      {required GetArticle article}) {
    return const [
      PopupMenuItem(
        value: ArticlePopMenuType.delete,
        child:  TextWithIcon(
          icon: Icons.delete,
          text: "delete",
        ),
     
      ),
       PopupMenuItem(
        value: ArticlePopMenuType.update,
        child:  TextWithIcon(
          icon: Icons.edit,
          text: "update",
        ),
      
       
       
         
      
      )
    ];
  }

  BoxDecoration decoration(BuildContext context) {
    return BoxDecoration(color: AppColors.articleBackground, boxShadow: [
      BoxShadow(
          blurRadius: 5,
          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
          spreadRadius: -4,
          offset: const Offset(0, 1))
    ]);
  }


}

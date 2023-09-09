import 'route_name.dart';
import '../../../features/article/pages/article_detail.dart';
import '../../../features/article/pages/create_or_update_article_page.dart';
import '../../../features/auth/page/login.dart';
import '../../../features/auth/page/sign_up.dart';
import '../../../features/auth/page/verification_page.dart';
import '../../../features/load_rqm/load_rqm_page.dart';
import '../../../features/message/pages/chat_page.dart';
import '../../../features/navbar/pages/navbar.dart';
import '../../../features/profile/pages/edit_profile_page.dart';
import '../../../features/profile/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../../widgets/interactive_image_view.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings setting) {
    return MaterialPageRoute(builder: (context) {
      switch (setting.name) {
        case AppRouteName.login:
          return const LoginPage();
        case AppRouteName.register:
          return const SignUpPage();
        case AppRouteName.loadRQM:
          return const LoadRQM();
        case AppRouteName.navbar:
          return const NavBarPage();
        case AppRouteName.createArticle:
          return const CreateOrUpdateArticlePage();
        case AppRouteName.updateArticle:
          final data = setting.arguments as Map<String, dynamic>;
          return CreateOrUpdateArticlePage(
            article: data['article'],
          );
        case AppRouteName.verificationPage:
          return const VerificationPage();
        case AppRouteName.editProfile:
          final data = setting.arguments as Map<String, dynamic>;
          return EditProfilePage(
            user: data['user'],
          );
        case AppRouteName.interactiveViewImage:
          final data = setting.arguments as Map<String, dynamic>;
          return InteractiveImageViewerPage(
            imageUrl: data['imageUrl'],
            tag: data['tag'],
          );
        case AppRouteName.profile:
          final data = setting.arguments as Map<String, dynamic>?;
          return ProfilePage(
            userId: data?['userId'],
          );
        case AppRouteName.articleDetailPage:
          final data = setting.arguments as Map<String, dynamic>?;
          return ArticleDetailPage(
            article: data?['article'],
          );

          case AppRouteName.chatPage:
              final data = setting.arguments as Map<String, dynamic>;
          return ChatPage(
            chatRoomIndividual: data['chatRoomIndividual'],
          );

        default:
          return Container(
            color: Colors.red,
            child: const Text("Route failed"),
          );
      }
    });
  }
}

import '../article/blocs/article_cud_cubit/article_cud_cubit.dart';
import '../article/blocs/article_read_cubit/article_read_cubit.dart';
import '../auth/repositories/user_repository.dart';
import '../auth/blocs/logout_cubit/logout_cubit.dart';
import '../auth/blocs/signin_cubit/signin_cubit.dart';
import '../auth/repositories/logout_repository.dart';
import '../auth/repositories/signin_repository.dart';
import '../auth/repositories/signup_repository.dart';
import '../comment_article/blocs/article_comment_cud/article_comment_cud_cubit.dart';
import '../comment_article/blocs/article_comment_read/article_comment_read_cubit.dart';
import '../follower_following/blocs/following_cubit/following_cubit.dart';
import '../message/blocs/message_cubit/message_cubit.dart';
import '../message/blocs/messaged_users_cubit/messaged_users_cubit.dart';
import '../navbar/blocs/change_navbar_index_cubit/change_navbar_indexer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../article/blocs/toolbar_visibility/quil_toolbar_visibibility_cubit.dart';
import '../auth/blocs/registration_cubit/registration_cubit.dart';
import '../auth/blocs/user_cubit/user_cubit.dart';
import '../follower_following/blocs/following_and_follower_count/following_and_follower_count_cubit.dart';
import '../internet_checker/blocs/internet_status_cubit/internet_status_cubit.dart';
import '../like_article/bloc/article_like_cubit/article_like_cubit.dart';
import '../profile/blocs/collection_user_cubit/collection_user_cubit.dart';
import '../profile/blocs/collection_user_du/collection_user_du_cubit.dart';
import '../profile/repositories/user_collection_repository.dart';

class Repository {
  static get all => [
        RepositoryProvider(
          create: (context) => UserRepository.getInstance(),
        ),
        RepositoryProvider(
          create: (context) => SignInRepository(),
        ),
        RepositoryProvider(
          create: (context) => SignupRepository(),
        ),
        RepositoryProvider(
          create: (context) => UserLogoutRepository(),
        ),
        RepositoryProvider(
          create: (context) => UserCollectionRepository.getInstance(),
        ),
      ];
}

class BlocProviderData {
  static get all => [
        BlocProvider(create: (context) => ChangeNavbarIndexerCubit()),
        BlocProvider(
          create: (context) => InternetStatusCubit(),
          lazy: false,
        ),
        BlocProvider(
            create: (context) => SigninCubit(
                signInRepository:
                    RepositoryProvider.of<SignInRepository>(context))),
        BlocProvider(
            create: (context) => RegistrationCubit(
                signupRepository:
                    RepositoryProvider.of<SignupRepository>(context),
                userCollectionRepo:
                    RepositoryProvider.of<UserCollectionRepository>(context))),
        BlocProvider(
            create: (context) => LogoutCubit(
                repository:
                    RepositoryProvider.of<UserLogoutRepository>(context))),
        BlocProvider(
            create: (context) => UserCubit(
                repository: RepositoryProvider.of<UserRepository>(context))),
        BlocProvider(create: (context) => ArticleLikeCubit()),
        BlocProvider(
            create: (context) => ArticleReadCubit(
                articleLikeCubit: BlocProvider.of<ArticleLikeCubit>(context))),
        BlocProvider(create: (context) => ArticleCudCubit()),
        BlocProvider(
          create: (context) => QuilToolbarVisibibilityCubit(),
        ),
        BlocProvider(
            create: (context) => CollectionUserCubit(
                repository:
                    RepositoryProvider.of<UserCollectionRepository>(context))),
        BlocProvider(
          create: (context) => CollectionUserDuCubit(
              userCubit: BlocProvider.of<CollectionUserCubit>(context)),
        ),
        BlocProvider(create: (context) => ArticleCommentCudCubit()),
        BlocProvider(create: (context) => FollowingCubit()),
        BlocProvider(create: (context) => FollowingAndFollowerCountCubit()),
        BlocProvider(create: (context) => ArticleCommentReadCubit()),
        BlocProvider(create: (context) => MessageCubit()),
        BlocProvider(create: (context) => MessagedUsersCubit()..getMessagedUsers()),
        
      ];
}

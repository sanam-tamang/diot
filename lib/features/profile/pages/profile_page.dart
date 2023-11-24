import 'dart:developer';

import '../../../core/widgets/annoted_region.dart';
import '../../../core/widgets/custom_circular_progress_widget.dart';
import '../../auth/repositories/user_repository.dart';
import '../widgets/build_article_by_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/route/route_name.dart';
import '../../../core/model/user.dart';
import '../../../core/widgets/custom_error_message_widget.dart';
import '../../auth/blocs/logout_cubit/logout_cubit.dart';
import '../blocs/collection_user_cubit/collection_user_cubit.dart';

import '../widgets/build_profile_body.dart';
import '../widgets/build_profile_header_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    this.userId,
  });
  final String? userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    ///fetch user data if not already exist
    final currentUserId =
        widget.userId ?? UserRepository.getInstance().currentUser!.uid;
    final state = context.read<CollectionUserCubit>().state;
    if (state is CollectionUserLoaded) {
      state.user.userId == currentUserId ? null : _fetchUser(currentUserId);
    } else {
      _fetchUser(currentUserId);
    }

    log(widget.userId.toString());
    super.initState();
  }

  void _fetchUser(String userId) {
    context.read<CollectionUserCubit>().getUserData(userId: userId);
  }

  @override
  Widget build(BuildContext context) {
    log("I am building from profile");
    return WillPopScope(
      onWillPop: () async {
        ///fetch the previous visited profile data
        context.read<CollectionUserCubit>().getPreviouslyVisitedUser();
        return true;
      },
      child: Scaffold(
        body: CustomAnnotatedRegion(
          child: BlocBuilder<CollectionUserCubit, CollectionUserState>(
            builder: (context, state) {
              log(state.runtimeType.toString());
              if (state is CollectionUserLoaded) {
                return BuildProfile(user: state.user);
              } else if (state is CollectionUserFailure) {
                return CustomErrorMessageWidget(
                  message: state.message,
                );
              } else if (state is CollectionUserLoading) {
                return const CustomCircularProgressIndicator();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}

class BuildProfile extends StatelessWidget {
  const BuildProfile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        actions: [
          UserRepository.getInstance().currentUser?.uid == user.userId
              ? TextButton(
                  onPressed: () {
                    context.read<LogoutCubit>().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRouteName.login, (route) => false);
                  },
                  child: const Text("Logout"),
                )
              : const SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildProfileHeaderImage(user: user),
            BuildProfileBody(user: user),
            BuildArticlesByUser(user: user),
          ],
        ),
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../../core/extenstions/replace_more_than_two_new_line.dart';
import '../../follower_following/widgets/follow_action_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/model/user.dart';
import '../../follower_following/blocs/following_and_follower_count/following_and_follower_count_cubit.dart';

class BuildProfileBody extends StatefulWidget {
  const BuildProfileBody({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<BuildProfileBody> createState() => _BuildProfileBodyState();
}

class _BuildProfileBodyState extends State<BuildProfileBody> {
  @override
  void initState() {
    context
        .read<FollowingAndFollowerCountCubit>()
        .getFollowersAndFollowingUsers(userId: widget.user.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _name(),
          _followFollowingCountActions(),
          _bio(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  AutoSizeText _name() {
    return AutoSizeText(
      widget.user.name,
      maxLines: 1,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }

  Widget _bio() {
    return widget.user.bio == null
        ? const SizedBox.shrink()
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Intro",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(widget.user.bio!.replaceNewLineUpTo2(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.greyScale4,
                        )),
              ],
            ),
          );
  }

  Widget _followFollowingCountActions() {
    return BlocBuilder<FollowingAndFollowerCountCubit,
        FollowingAndFollowerCountState>(
      builder: (context, state) {
        if (state is FollowingAndFollowerCountLoaded) {
          return Row(
            children: [
              FollowActionCount(
                  count: state.followingAndFollowers.following,
                  text: "Following"),
              const SizedBox(
                width: 15,
              ),
              FollowActionCount(
                  count: state.followingAndFollowers.followers,
                  text: "Followers"),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

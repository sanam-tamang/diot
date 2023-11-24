import '../../../core/widgets/custom_circular_progress_widget.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../../core/widgets/text_with_icon.dart';
import '../blocs/following_cubit/following_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowingButton extends StatefulWidget {
  const FollowingButton({
    super.key,
    required this.userId,
  });

  ///currently visited profile id
  final String userId;

  @override
  State<FollowingButton> createState() => _FollowingButtonState();
}

class _FollowingButtonState extends State<FollowingButton> {
  @override
  void initState() {
    context
        .read<FollowingCubit>()
        .isFollowing(correntlyVisitedProfileId: widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowingCubit, FollowingState>(
        builder: (context, state) {
      if (state is FollowingLoading) {
        return const CustomCircularProgressIndicator();
      } else if (state is FollowingLoaded) {
        if (state.isFollowing) {
          return GestureDetector(
            onTap: _onPressFollowingButton,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(30)),
                child: const TextWithIcon(
                    color: Colors.white, text: 'Following', icon: Icons.check)),
          );
        } else {
          return CustomElevatedButton(
              onPressed: () => context
                  .read<FollowingCubit>()
                  .followUser(visitedProfileUserId: widget.userId),
              label: 'Follow');
        }
      } else {
        return const SizedBox();
      }
    });
  }

  Future<void> _onPressFollowingButton() async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            constraints: BoxConstraints(
                minHeight: 60,
                maxHeight: MediaQuery.of(context).size.height * 0.99),
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      context
                          .read<FollowingCubit>()
                          .unFollowUser(visitedProfileUserId: widget.userId);
                      Navigator.of(context).pop();
                    },
                    child: const TextWithIcon(
                        center: true,
                        text: 'Unfollow',
                        icon: Icons.person_remove_alt_1_rounded)),
              ],
            ),
          );
        });
  }
}

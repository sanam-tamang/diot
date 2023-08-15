// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:devmandu/core/config/route/route_name.dart';
import 'package:devmandu/core/enum/hero_tag_type.dart';
import 'package:devmandu/core/widgets/hero_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:devmandu/core/widgets/custom_cache_network_image.dart';

import '../../../core/config/size.dart';
import '../../../core/model/user.dart' as local;
import '../../../core/widgets/build_avatar_image.dart';
import '../../follower_following/widgets/following_button.dart';

class BuildProfileHeaderImage extends StatefulWidget {
  const BuildProfileHeaderImage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final local.User user;

  @override
  State<BuildProfileHeaderImage> createState() =>
      _BuildProfileHeaderImageState();
}

class _BuildProfileHeaderImageState extends State<BuildProfileHeaderImage> {
  @override
  Widget build(BuildContext context) {
    const double profileHeaderContainerHight = 240;
    return SizedBox(
      height: profileHeaderContainerHight,
      child: LayoutBuilder(builder: (context, constraint) {
        return Stack(children: [
          _buildBackgroundImage(constraint),
          _buildProfileImage(),
          _buildEditProfileButton(constraint),
        ]);
      }),
    );
  }

  Positioned _buildEditProfileButton(BoxConstraints constraint) {
    return Positioned(
        bottom: constraint.maxHeight * 0.06,
        right: 15,
        child: FirebaseAuth.instance.currentUser?.uid == widget.user.userId
            ? OutlinedButton(
                onPressed: _gotoEditProfile, child: const Text('Edit profile'))
            : FollowingButton(
                userId: widget.user.userId,
              ));
  }

  Positioned _buildProfileImage() {
    return Positioned(
      bottom: 0,
      left: 15,
      child: GestureDetector(
        onTap: widget.user.image == null
            ? null
            : () =>
                _gotoInteractiViewer(widget.user.image!, HeroTagType.profile),
        child: CustomHeroWidget(
          tag: widget.user.image == null
              ? HeroTagType.noAnimation
              : HeroTagType.profile,
          payload: widget.user.image ?? "",
          child: BuildAvatarImageNetwork(
              radius: profileSize, image: widget.user.image),
        ),
      ),
    );
  }

  Positioned _buildBackgroundImage(BoxConstraints constraint) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: constraint.maxHeight * 0.68,
        width: double.infinity,
        child: GestureDetector(
          onTap: widget.user.backgroudImage == null
              ? null
              : () => _gotoInteractiViewer(
                  widget.user.backgroudImage!, HeroTagType.noAnimation),
          child: CustomCacheNetworkImage(
            fit: BoxFit.cover,
            imageUrl: widget.user.backgroudImage,
          ),
        ),
      ),
    );
  }

  void _gotoInteractiViewer(String payload, [HeroTagType? tag]) {
    Navigator.of(context)
        .pushNamed(AppRouteName.interactiveViewImage, arguments: {
      "imageUrl": payload,
      "tag": tag,
    });
  }

  void _gotoEditProfile() {
    Navigator.of(context)
        .pushNamed(AppRouteName.editProfile, arguments: {"user": widget.user});
  }
}

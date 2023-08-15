import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../config/theme/app_colors.dart';
///network avatar image
class BuildAvatarImageNetwork extends StatelessWidget {
  const BuildAvatarImageNetwork({
    Key? key,
    required this.image,
    this.radius = 30,
  }) : super(key: key);
  final String? image;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: image != null
            ? CircleAvatar(
                radius: radius,
                backgroundImage: CachedNetworkImageProvider(
                  image!,
                ),
              )
            : CircleAvatar(
                radius: radius,
                backgroundColor: AppColors.greyScale8,
                backgroundImage: const AssetImage(
                  'assets/icons/person.png',
                ),
              ));
  }
}
///network avatar image
class BuildAvatarImageLocal extends StatelessWidget {
  const BuildAvatarImageLocal({
    Key? key,
    required this.image,
    this.radius = 30,
  }) : super(key: key);
  final Uint8List? image;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: image != null
            ? CircleAvatar(
                radius: radius,
                backgroundImage: MemoryImage(image!)
              )
            : CircleAvatar(
                radius: radius,
                backgroundColor: AppColors.greyScale8,
                backgroundImage: const AssetImage(
                  'assets/icons/person.png',
                ),
              ));
  }
}
